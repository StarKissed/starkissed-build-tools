/*
 * Copyright 2012, Denys Vlasenko
 *
 * Licensed under GPLv2, see file LICENSE in this source tree.
 */

//kbuild:lib-y += missing_syscalls.o

/*#include <linux/timex.h> - for struct timex, but may collide with <time.h> */
#include <sys/syscall.h>
#include "libbb.h"

#if defined(ANDROID) || defined(__ANDROID__)
pid_t getsid(pid_t pid)
{
	return syscall(__NR_getsid, pid);
}

int stime(const time_t *t)
{
	struct timeval tv;
	tv.tv_sec = *t;
	tv.tv_usec = 0;
	return settimeofday(&tv, NULL);
}

int sethostname(const char *name, size_t len)
{
	return syscall(__NR_sethostname, name, len);
}

struct timex;
int adjtimex(struct timex *buf)
{
	return syscall(__NR_adjtimex, buf);
}

int pivot_root(const char *new_root, const char *put_old)
{
	return syscall(__NR_pivot_root, new_root, put_old);
}

int swapoff(const char *path)
{
  return syscall(__NR_swapoff, path);
}

int swapon(const char *path, int swapflags)
{
  return syscall(__NR_swapon, path, swapflags);
}

int shmget(key_t key, size_t size, int shmflg)
{
  return syscall(__NR_shmget, key, size, shmflg);
}

int shmdt(const void *shmaddr)
{
  return syscall(__NR_shmdt, shmaddr);
}

void *shmat(int shmid, const void *shmaddr, int shmflg)
{
  return (void *)syscall(__NR_shmat, shmid, shmaddr, shmflg);
}

int msgget(key_t key, int msgflg)
{
  return syscall(__NR_msgget, key, msgflg);
}

int semget(key_t key, int nsems, int semflg)
{
  return syscall(__NR_semget, key, nsems, semflg);
}

ssize_t readahead(int fd, off64_t offset, size_t count)
{
  return syscall(__NR_readahead, fd, offset, count);
}

struct msqid_ds; /* #include <linux/msg.h> */
int msgctl(int msqid, int cmd, struct msqid_ds *buf)
{
  return syscall(__NR_msgctl, msqid, cmd, buf);
}

struct shmid_ds; /* #include <linux/shm.h> */
// NOTE: IPC_INFO takes a struct shminfo64
int shmctl(int shmid, int cmd, struct shmid_ds *buf)
{
  return syscall(__NR_shmctl, shmid, cmd, buf);
}

struct sembuf; /* #include <linux/sem.h> */
int semop(int semid, struct sembuf *sops, unsigned nsops)
{
  return syscall(__NR_semop, semid, sops, nsops);
}
#endif
