Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7289E7D1C5F
	for <lists+dmaengine@lfdr.de>; Sat, 21 Oct 2023 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUKLA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Oct 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJUKK6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Oct 2023 06:10:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EA1BF;
        Sat, 21 Oct 2023 03:10:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso1582008276.3;
        Sat, 21 Oct 2023 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883055; x=1698487855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X6dsTPw04Ec03sx55MCB4H0A0mnvHi81LKg2m7LwMmY=;
        b=cjRYIZPyezlsI5gzr5vQky3yHOUn8xJ5WDpjIKMACIrK8spkby59pWKiuyMZcHvHsM
         EokrdIXOdSLuhw2MqP0rqfEbkCGvrCiNduvaaA1PWKPcQQ8qgqWlMws9OdDJv5rfV68A
         BsLSvd3JgjzHghPVoraQfibTCPKdemBt8tHJfgy+x0H1ZOUJnHuVJpAtu9f8wbaXOqHZ
         OHHDdYoIy2+ieB2J10zXaxYNiJhWOGdaXLREDvKF9UqdcatFDQp+fYE+cFXYkLv4jFuF
         BC9mhrcqlXwP2QDrg/edKu9uKJ0ERqOSeUkGF9C82L4EPe01mRM0cmgYjiWj3Z0gXB33
         55Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883055; x=1698487855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6dsTPw04Ec03sx55MCB4H0A0mnvHi81LKg2m7LwMmY=;
        b=KRcPHiZVho1eSnUx7H7N4/wY+VWDA4c4vcpH+csvoHTIP+ticRVH0S72GPuzh7yWY+
         exdBYRiELUMWz6FlH380vdgR3By7qG9/JXfGIuEQffmBn3efPhT4Lbac8dmqsRzZGDO9
         eBxzGCMm6UboBIRTojb75H8zimsJxH3J6JzQpsL0Dtnnd7bwGp54kU+bk37CpDh3sogc
         0PNR2U+ViBrfQ09Oyk/R9BZcglkC+EhGETMEV+FB4Kj3mAyY2q2bAQdyaj5UAlIDkKSM
         TBt4KKbcu6AoCd+aspoI8s78A5IA6R9LlokuCJZ+vq3KHhL7f+Bfsdjmn+KNM05j6EiA
         ybMg==
X-Gm-Message-State: AOJu0YysSgyK/m+iEJ3nPJrWMmIkqXCVRIW0+H8YB1QjKg5hoQ7BBZBk
        g7hl3wn2X6EsU0dFAdu88o5ZCSINUg3OE//6On0=
X-Google-Smtp-Source: AGHT+IERq//gybkyJTpTG5FGIW0rEcTBzFxqB5jbfdqmkJvbR4mTW0nJAzYk+QmIKodlR86Y478NkZqiZDyWbynKz2I=
X-Received: by 2002:a25:902:0:b0:d9c:2b72:4fa5 with SMTP id
 2-20020a250902000000b00d9c2b724fa5mr4116715ybj.48.1697883055257; Sat, 21 Oct
 2023 03:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
In-Reply-To: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Sat, 21 Oct 2023 18:10:44 +0800
Message-ID: <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in sdebug_error_write()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        dmaengine@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000061184b06083734f4"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--00000000000061184b06083734f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> There are two bug in this code:

Thanks for your fix, some different points of view as follows.

> 1) If count is zero, then it will lead to a NULL dereference.  The
> kmalloc() will successfully allocate zero bytes and the test for
> "if (buf[0] =3D=3D '-')" will read beyond the end of the zero size buffer
> and Oops.

This sysfs interface is usually used by cmdline, mostly, "echo" is used
to write it and "echo" always writes with '\n' terminated, which would
not cause a write with count=3D0.

While in terms of security, we should add a check for count=3D=3D0
condition and return EINVAL.

> 2) The code does not ensure that the user's string is properly NUL
> terminated which could lead to a read overflow.
>

I don't think so, the copy_from_user() would limit the accessed length
to count, so no read overflow would happen.

Userspace's write would allocate a buffer larger than it actually
needed(usually 4K), but the buffer would not be cleared, so some
dirty data would be passed to the kernel space.

We might have following pairs of parameters for sdebug_error_write:

ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
count=3D11

the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
strndup_user() would return EINVAL for this pair which caused
a correct write to fail.

You can recurrent the above error with my script attached.

Thanks.

> Fortunately, this is debugfs code and only root can write to it so
> the security impact of these bugs is negligable.
>
> Fixes: a9996d722b11 ("scsi: scsi_debug: Add interface to manage error inj=
ection for a single device")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/scsi/scsi_debug.c                      | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 67922e2c4c19..0a4e41d84df8 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -1019,14 +1019,9 @@ static ssize_t sdebug_error_write(struct file *fil=
e, const char __user *ubuf,
>         struct sdebug_err_inject *inject;
>         struct scsi_device *sdev =3D (struct scsi_device *)file->f_inode-=
>i_private;
>
> -       buf =3D kmalloc(count, GFP_KERNEL);
> -       if (!buf)
> -               return -ENOMEM;
> -
> -       if (copy_from_user(buf, ubuf, count)) {
> -               kfree(buf);
> -               return -EFAULT;
> -       }
> +       buf =3D strndup_user(ubuf, count + 1);
> +       if (IS_ERR(buf))
> +               return PTR_ERR(buf);
>
>         if (buf[0] =3D=3D '-')
>                 return sdebug_err_remove(sdev, buf, count);
> --
> 2.42.0
>

--00000000000061184b06083734f4
Content-Type: text/x-sh; charset="US-ASCII"; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_lnzvli7k0>
X-Attachment-Id: f_lnzvli7k0

ZnVuY3Rpb24gY2xlYXJfZGlza19lcnJvcigpCnsKCWxvY2FsIHN0cj0kKGxzc2NzaSB8IGdyZXAg
c2NzaV9kZWJ1ZyB8IGdyZXAgJDEgfCBhd2sgJ3twcmludCAkMX0nKQoJbG9jYWwgc2NzaV9pZD0k
e3N0ciMqXFt9Cglsb2NhbCBzY3NpX2lkPSR7c2NzaV9pZCVcXSp9Cglsb2NhbCBlcnJvcj0vc3lz
L2tlcm5lbC9kZWJ1Zy9zY3NpX2RlYnVnLyRzY3NpX2lkL2Vycm9yIAoJbG9jYWwgdGFyZ2V0X2lk
PSR7c2NzaV9pZCVcOip9CgoJdG1wZmlsZT0kJF9jbGVhcgoJY2F0ICRlcnJvcgoJY2F0ICRlcnJv
ciB8IGdyZXAgLXYgVHlwZSB8IGF3ayAne3ByaW50ICQxLCQzfScgPiAkdG1wZmlsZSAKCXdoaWxl
IHJlYWQgLXIgbGluZTsgZG8gZWNobyAiLSAkbGluZSIgPiAkZXJyb3I7IGRvbmUgPCAkdG1wZmls
ZQoJcm0gLXJmICR0bXBmaWxlCgoJZWNobyAwID4gL3N5cy9rZXJuZWwvZGVidWcvc2NzaV9kZWJ1
Zy90YXJnZXQkdGFyZ2V0X2lkL2ZhaWxfcmVzZXQKfQoKZnVuY3Rpb24gZGlza19pZCgpCnsKCWxv
Y2FsIHN0cj0kKGxzc2NzaSB8IGdyZXAgc2NzaV9kZWJ1ZyB8IGdyZXAgJDEgfCBhd2sgJ3twcmlu
dCAkMX0nKQoJbG9jYWwgc2NzaV9pZD0ke3N0ciMqXFt9Cglsb2NhbCBzY3NpX2lkPSR7c2NzaV9p
ZCVcXSp9CgllY2hvICRlcnJvcgp9CgpmdW5jdGlvbiBkaXNrX3RhcmdldF9pZCgpCnsKCWxvY2Fs
IHN0cj0kKGxzc2NzaSB8IGdyZXAgc2NzaV9kZWJ1ZyB8IGdyZXAgJDEgfCBhd2sgJ3twcmludCAk
MX0nKQoJbG9jYWwgc2NzaV9pZD0ke3N0ciMqXFt9Cglsb2NhbCBzY3NpX2lkPSR7c2NzaV9pZCVc
XSp9Cglsb2NhbCB0YXJnZXRfaWQ9JHtzY3NpX2lkJVw6Kn0KCgllY2hvICR0YXJnZXRfaWQKfQoK
ZnVuY3Rpb24gZGlza19lcnJvcigpCnsKCWxvY2FsIHN0cj0kKGxzc2NzaSB8IGdyZXAgc2NzaV9k
ZWJ1ZyB8IGdyZXAgJDEgfCBhd2sgJ3twcmludCAkMX0nKQoJbG9jYWwgc2NzaV9pZD0ke3N0ciMq
XFt9Cglsb2NhbCBzY3NpX2lkPSR7c2NzaV9pZCVcXSp9Cglsb2NhbCBlcnJvcj0vc3lzL2tlcm5l
bC9kZWJ1Zy9zY3NpX2RlYnVnLyRzY3NpX2lkL2Vycm9yIAoKCWVjaG8gJGVycm9yCn0KCiMgdGlt
ZSBvdXQgYW5kIGFib3J0IGZhaWxlZCBjb21tYW5kCiMgd291bGQgdHJpZ2dlciBlcnJvciByZWNv
dmVyeSBmcm9tIHRpbWVvdXQKIyAkMTogZGlza25hbWUKIyAkMjogY29tbWFuZCBuYW1lCiMgJDM6
IHJ1bGUgdGltZQpmdW5jdGlvbiBpbmplY3RfVElNRU9VVF9BQk9SVCgpCnsKCWVycm9yPSQoZGlz
a19lcnJvciAkMSkKCWVjaG8gIjAgJDMgJDIiID4gJHtlcnJvcn0KCWVjaG8gIjMgJDMgJDIiID4g
JHtlcnJvcn0KfQoKIyBmaW5pc2ggY29tbWFuZCB3aXRoIERJRF9USU1FX09VVAojIHdvdWxkIHRy
aWdnZXIgZXJyb3IgcmVjb3Zlcnkgd2hlbiBjb21tYW5kIGZpbmloZWQgaW4gc2NzaV9kZWNpZGVf
cG9zaXRpb24KIyAkMTogZGlza25hbWUKIyAkMjogY29tbWFuZCBuYW1lCiMgJDM6IHJ1bGUgdGlt
ZQpmdW5jdGlvbiBpbmplY3RfRElEX1RJTUVfT1VUKCkKewoJZXJyb3I9JChkaXNrX2Vycm9yICQx
KQoJZWNobyAiMiAkMyAkMiAweDMgMCAwIDAgMCAwIiA+ICR7ZXJyb3J9Cn0KCiMgZmluaXNoIGNv
bW1hbmQgd2l0aCBMVU4gTk9UIFJFQURZLCBJTklUSUFMSVpJTkcgQ09NTUFORCBSRVFVSVJFRAoj
IHdvdWxkIHRyaWdnZXIgZXJyb3IgcmVjb3Zlcnkgd2hlbiBjb21tYW5kIGZpbmloZWQgaW4gc2Nz
aV9jaGVja19zZW5zZQojIHN0YXR1czogMHgyCiMgc2Vuc2Vfa2V5OiAweDYKIyBhc2M6IDB4NAoj
IGFzY3E6IDB4MgojICQxOiBkaXNrbmFtZQojICQyOiBjb21tYW5kIG5hbWUKIyAkMzogcnVsZSB0
aW1lCmZ1bmN0aW9uIGluamVjdF9MVU5fTk9UX1JFQURZKCkKewoJZXJyb3I9JChkaXNrX2Vycm9y
ICQxKQoJZWNobyAiMiAkMyAkMiAwIDAgMHgyIDB4NiAweDQgMHgyIiA+ICR7ZXJyb3J9Cn0KCiMg
ZmluaXNoIGNvbW1hbmQgd2l0aCBNZWRpdW0gRXJyb3IKIyB3b3VsZCBub3QgdHJpZ2dlciBlcnJv
ciByZWNvdmVyeSBidXQgRUlPIGlzIHRyaWdnZXJlZAojICQxOiBkaXNrbmFtZQojICQyOiBjb21t
YW5kIG5hbWUKIyAkMzogcnVsZSB0aW1lCmZ1bmN0aW9uIGluamVjdF9NRURJVU1fRVJST1IoKQp7
CgllcnJvcj0kKGRpc2tfZXJyb3IgJDEpCgllY2hvICIyICQzICQyIDAgMCAweDIgMHgzIDB4MTEg
MHgwIiA+ICR7ZXJyb3J9Cn0KCiMgZGV2aWNlIHJlc2V0IGZhaWxlZCBmb3IgMTAgdGltZQojICQx
OiBkaXNrIG5hbWUgdG8gaW5qZWN0LCBmb3IgZXhhbXBsZSBzZGEKZnVuY3Rpb24gcmVjb3Zlcnlf
aW5qZWN0MSgpCnsKCWVycm9yPSQoZGlza19lcnJvciAkMSkKCWVjaG8gIjQgLTEwIDB4ZmYiID4g
JHtlcnJvcn0KfQoKIyB0YXJnZXQgZmFpbGVkIGZvciAxMCB0aW1lCiMgJDE6IGRpc2sgbmFtZSB0
byBpbmplY3QsIGZvciBleGFtcGxlIHNkYQpmdW5jdGlvbiByZWNvdmVyeV9pbmplY3QyKCkKewoJ
dGFyZ2V0X2lkPSQoZGlza190YXJnZXRfaWQgJDEpCgoJZWNobyAxID4gL3N5cy9rZXJuZWwvZGVi
dWcvc2NzaV9kZWJ1Zy90YXJnZXQkdGFyZ2V0X2lkL2ZhaWxfcmVzZXQKfQoKZnVuY3Rpb24gcmVj
b3ZlcnlfaW5qZWN0MygpCnsKCWluamVjdF9ESURfVElNRV9PVVQgJDEgMHgxMiAtMTAKfQoKZnVu
Y3Rpb24gcmVjb3ZlcnlfaW5qZWN0NCgpCnsKCWluamVjdF9MVU5fTk9UX1JFQURZICQxIDB4MTIg
LTEwCn0KCmZ1bmN0aW9uIHJlY292ZXJ5X2luamVjdDUoKQp7CglpbmplY3RfVElNRU9VVF9BQk9S
VCAkMSAweDEyIC0xMAp9CgpmdW5jdGlvbiByZWNvdmVyeV9pbmplY3Q2KCkKewoJaW5qZWN0X0RJ
RF9USU1FX09VVCAkMSAweDFiIC0xMAp9CgpmdW5jdGlvbiByZWNvdmVyeV9pbmplY3Q3KCkKewoJ
aW5qZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHgxYiAtMTAKfQoKZnVuY3Rpb24gcmVjb3ZlcnlfaW5q
ZWN0OCgpCnsKCWluamVjdF9USU1FT1VUX0FCT1JUICQxIDB4MWIgLTEwCn0KCmZ1bmN0aW9uIGVy
cm9yX2luamVjdDEoKQp7CglpbmplY3RfVElNRU9VVF9BQk9SVCAkMSAweDI4IC0xMAp9CgpmdW5j
dGlvbiBlcnJvcl9pbmplY3QyKCkKewoJaW5qZWN0X1RJTUVPVVRfQUJPUlQgJDEgMHhhOCAtMTAK
fQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0MygpCnsKCWluamVjdF9USU1FT1VUX0FCT1JUICQxIDB4
ODggLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDQoKQp7CglpbmplY3RfVElNRU9VVF9BQk9S
VCAkMSAweDJhIC0xMAp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3Q1KCkKewoJaW5qZWN0X1RJTUVP
VVRfQUJPUlQgJDEgMHhhYSAtMTAKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0NigpCnsKCWluamVj
dF9USU1FT1VUX0FCT1JUICQxIDB4OGEgLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDcoKQp7
CglpbmplY3RfVElNRU9VVF9BQk9SVCAkMSAweDI4IDEKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0
OCgpCnsKCWluamVjdF9USU1FT1VUX0FCT1JUICQxIDB4YTggMQp9CgpmdW5jdGlvbiBlcnJvcl9p
bmplY3Q5KCkKewoJaW5qZWN0X1RJTUVPVVRfQUJPUlQgJDEgMHg4OCAxCn0KCmZ1bmN0aW9uIGVy
cm9yX2luamVjdDEwKCkKewoJaW5qZWN0X1RJTUVPVVRfQUJPUlQgJDEgMHgyYSAxCn0KCmZ1bmN0
aW9uIGVycm9yX2luamVjdDExKCkKewoJaW5qZWN0X1RJTUVPVVRfQUJPUlQgJDEgMHhhYSAxCn0K
CmZ1bmN0aW9uIGVycm9yX2luamVjdDEyKCkKewoJaW5qZWN0X1RJTUVPVVRfQUJPUlQgJDEgMHg4
YSAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDEzKCkKewoJaW5qZWN0X0RJRF9USU1FX09VVCAk
MSAweDI4IC0xMAp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3QxNCgpCnsKCWluamVjdF9ESURfVElN
RV9PVVQgJDEgMHhhOCAtMTAKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0MTUoKQp7CglpbmplY3Rf
RElEX1RJTUVfT1VUICQxIDB4ODggLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDE2KCkKewoJ
aW5qZWN0X0RJRF9USU1FX09VVCAkMSAweDJhIC0xMAp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3Qx
NygpCnsKCWluamVjdF9ESURfVElNRV9PVVQgJDEgMHhhYSAtMTAKfQoKZnVuY3Rpb24gZXJyb3Jf
aW5qZWN0MTgoKQp7CglpbmplY3RfRElEX1RJTUVfT1VUICQxIDB4OGEgLTEwCn0KCmZ1bmN0aW9u
IGVycm9yX2luamVjdDE5KCkKewoJaW5qZWN0X0RJRF9USU1FX09VVCAkMSAweDI4IDEKfQoKZnVu
Y3Rpb24gZXJyb3JfaW5qZWN0MjAoKQp7CglpbmplY3RfRElEX1RJTUVfT1VUICQxIDB4YTggMQp9
CgpmdW5jdGlvbiBlcnJvcl9pbmplY3QyMSgpCnsKCWluamVjdF9ESURfVElNRV9PVVQgJDEgMHg4
OCAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDIyKCkKewoJaW5qZWN0X0RJRF9USU1FX09VVCAk
MSAweDJhIDEKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0MjMoKQp7CglpbmplY3RfRElEX1RJTUVf
T1VUICQxIDB4YWEgMQp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3QyNCgpCnsKCWluamVjdF9ESURf
VElNRV9PVVQgJDEgMHg4YSAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDI1KCkKewoJaW5qZWN0
X0xVTl9OT1RfUkVBRFkgJDEgMHgyOCAtMTAKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0MjYoKQp7
CglpbmplY3RfTFVOX05PVF9SRUFEWSAkMSAweGE4IC0xMAp9CgpmdW5jdGlvbiBlcnJvcl9pbmpl
Y3QyNygpCnsKCWluamVjdF9MVU5fTk9UX1JFQURZICQxIDB4ODggLTEwCn0KCmZ1bmN0aW9uIGVy
cm9yX2luamVjdDI4KCkKewoJaW5qZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHgyYSAtMTAKfQoKZnVu
Y3Rpb24gZXJyb3JfaW5qZWN0MjkoKQp7CglpbmplY3RfTFVOX05PVF9SRUFEWSAkMSAweGFhIC0x
MAp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3QzMCgpCnsKCWluamVjdF9MVU5fTk9UX1JFQURZICQx
IDB4OGEgLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDMxKCkKewoJaW5qZWN0X0xVTl9OT1Rf
UkVBRFkgJDEgMHgyOCAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDMyKCkKewoJaW5qZWN0X0xV
Tl9OT1RfUkVBRFkgJDEgMHhhOCAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDMzKCkKewoJaW5q
ZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHg4OCAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDM0KCkK
ewoJaW5qZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHgyYSAxCn0KCmZ1bmN0aW9uIGVycm9yX2luamVj
dDM1KCkKewoJaW5qZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHhhYSAxCn0KCmZ1bmN0aW9uIGVycm9y
X2luamVjdDM2KCkKewoJaW5qZWN0X0xVTl9OT1RfUkVBRFkgJDEgMHg4YSAxCn0KCmZ1bmN0aW9u
IGVycm9yX2luamVjdDM3KCkKewoJaW5qZWN0X01FRElVTV9FUlJPUiAkMSAweDI4IC0xMAp9Cgpm
dW5jdGlvbiBlcnJvcl9pbmplY3QzOCgpCnsKCWluamVjdF9NRURJVU1fRVJST1IgJDEgMHhhOCAt
MTAKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0MzkoKQp7CglpbmplY3RfTUVESVVNX0VSUk9SICQx
IDB4ODggLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDQwKCkKewoJaW5qZWN0X01FRElVTV9F
UlJPUiAkMSAweDJhIC0xMAp9CgpmdW5jdGlvbiBlcnJvcl9pbmplY3Q0MSgpCnsKCWluamVjdF9N
RURJVU1fRVJST1IgJDEgMHhhYSAtMTAKfQoKZnVuY3Rpb24gZXJyb3JfaW5qZWN0NDIoKQp7Cglp
bmplY3RfTUVESVVNX0VSUk9SICQxIDB4OGEgLTEwCn0KCmZ1bmN0aW9uIGVycm9yX2luamVjdDQz
KCkKewoJaW5qZWN0X01FRElVTV9FUlJPUiAkMSAweDI4IDEKfQoKZnVuY3Rpb24gZXJyb3JfaW5q
ZWN0NDQoKQp7CglpbmplY3RfTUVESVVNX0VSUk9SICQxIDB4YTggMQp9CgpmdW5jdGlvbiBlcnJv
cl9pbmplY3Q0NSgpCnsKCWluamVjdF9NRURJVU1fRVJST1IgJDEgMHg4OCAxCn0KCmZ1bmN0aW9u
IGVycm9yX2luamVjdDQ2KCkKewoJaW5qZWN0X01FRElVTV9FUlJPUiAkMSAweDJhIDEKfQoKZnVu
Y3Rpb24gZXJyb3JfaW5qZWN0NDcoKQp7CglpbmplY3RfTUVESVVNX0VSUk9SICQxIDB4YWEgMQp9
CgpmdW5jdGlvbiBlcnJvcl9pbmplY3Q0OCgpCnsKCWluamVjdF9NRURJVU1fRVJST1IgJDEgMHg4
YSAxCn0KCmZvciBpIGluICQoc2VxIDEgOCk7CmRvCgllY2hvICRpCglyZWNvdmVyeV9pbmplY3Qk
aSBzZGEKZG9uZQoKZm9yIGkgaW4gJChzZXEgMSA0OCk7CmRvCgllY2hvICRpCgllcnJvcl9pbmpl
Y3QkaSBzZGEKZG9uZQoK
--00000000000061184b06083734f4--
