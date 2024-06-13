Return-Path: <dmaengine+bounces-2356-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4967906545
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9932A1F22196
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D0136997;
	Thu, 13 Jun 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGFmsh5I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B713C3F0
	for <dmaengine@vger.kernel.org>; Thu, 13 Jun 2024 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264127; cv=none; b=FefNxaN+c/aNEZETQjOxDxFDLZ1vFnt/yvR+/6NO2nMrkiLrckDRYAB0pkDN+KUosvtkpGEEPA2OXnJQ9fAJy/vFxYKH6imXHKJsT4tzb8ps8GdMBfUb/eSUmd5+1F6cmEk/uCVnvhULgT2gOV1EHGY7EMfscrTW62Lh6ZER29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264127; c=relaxed/simple;
	bh=hvFkWqgqjN3aIEgxJVhBxYCwDHO7XP728MlzAqv3QUY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E1cbphC0OuQcNiAns0owGxnpq6KmkeKzOPNs8WPizYcskVFGaDSm91nMuJMFGHhgFRGFvphwcc1U3bB7Iyq5E0vDZiASdOKg4xyYdOhzK1JLXj5glbbLdGcI8ISHlLZd2VRjQXu+3QPC3Uvk8x/cxTQoGYAukvatT+Fbs0VSmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGFmsh5I; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1640484e87.0
        for <dmaengine@vger.kernel.org>; Thu, 13 Jun 2024 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718264121; x=1718868921; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KjtNF6q9FfDcy5+zoTC+FmH6coa/1b8KQLf3ofkGuno=;
        b=SGFmsh5ITLWDek5SkY0vnkaRxJiJb/6i3qMgMYBrBn55sCpzs017VOB/1IQFqYkuM/
         oHfjWcYEd4cXm1i7rP20Lp2wL5yCve3Tpr0hc0kHMLy4WHyrUpeX6uMoGC+VdwTUTTm8
         hPsbn1SnYHTZ6LK7Lvbeos2oitz+neuiQnveILYfpZEN8QaJjYnvoQL4EbNzXKXCKgK3
         5fg22mMcYW2to1PMXqDWZ7M/kpGL2Cuviasys+YfRWyH4UKa8DVSmVKYSeglMo4B8GT4
         WEbpKBebbIoc/LC46f6QKU3gJbFYVCg5kRoaEuW6GOKG0eS12jTDq1uzHZvsb6T2tZNc
         Ec6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264121; x=1718868921;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjtNF6q9FfDcy5+zoTC+FmH6coa/1b8KQLf3ofkGuno=;
        b=jNifIj04hpkLafCnOa5AZO/OCKALrXphhipO6Lz/6OOkyKGeyRT3ArmJE46UxD84w1
         1EJAKnJNLnhuDblxbwFPRJztM1CcGUiRbJatJwwOCf4Lw+PKhciCelXrgzk5WsjSDAeA
         Oddg0fowjRlH/knvQF9uOzRdgWzDUwmiO2uY539Mf4Q0rMyECfI1ynnlquyaQ3l2Qp3t
         ay90m2y0Faj0beSFovkOkhZVpiwqCDriJuNwtZff1nf/IVxtiIqzK+jfkRMMBlsLvauS
         HxNdS3FtCUkIh5IXAusN+9VOo/hLeyYHcaolBX8EXHdoFyAKyQ/7Geiwa8DvGgv4//4K
         /wsg==
X-Gm-Message-State: AOJu0YwLLnx0U3NEqcK3rKyy3IzWBxMqPw98mPrj0naMu8x3iO4EbXvf
	BNFHhNb07iSTp5L+6gDjwIogDZo2/M7B8W+vxw8H1HDxu2kJmB7KagHXZknoImmiV+qYHv1rFYF
	UuWNpouV3njr3+6IWqHGnWZ7e8ptLQ0FsBqI=
X-Google-Smtp-Source: AGHT+IH0EdR5iGi0XabIRMQF8JOfge14zc+0lvjInhHsLteObpIQm2DwKJjChxB/vOnrdj616wAfJ28UDjtvh6gIJGc=
X-Received: by 2002:ac2:5b9a:0:b0:52c:8372:9803 with SMTP id
 2adb3069b0e04-52ca022794fmr598304e87.12.1718264121411; Thu, 13 Jun 2024
 00:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anthony Clark <clark.anthony.g@gmail.com>
Date: Thu, 13 Jun 2024 00:34:55 -0700
Message-ID: <CALcKWQiZ8uhZrx2-MPpZJ_5zhF2YQRnNf_zDut9Xvg-EE28tCg@mail.gmail.com>
Subject: Handling DMA completion timeouts
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey all,

I sent nearly this same message to the "kernelnewbies" mailing list
(kernelnewbies@kernelnewbies.org) in hopes to get some response there.
I haven't heard anything back and I see this mailing list referenced
in various documentation. I hope this message is appropriate for this
audience.

As a newbie, I'm trying to figure out how to properly deal with
timeouts after dma_engine_submit(). My intent is to build a new
"device" driver using Xilinx's AXIDMA driver linked below. Xilinx
provides a couple references called "dma-proxy" and "axidmatest" that
exercise the DMA Engine interop with their driver. I think I
understand this layering correctly, but I'm pretty new to the DMA
Engine framework.

xilinx dma driver:
https://github.com/Xilinx/linux-xlnx/blob/master/drivers/dma/xilinx/xilinx_dma.c
dma-proxy driver:
https://github.com/Xilinx-Wiki-Projects/software-prototypes/blob/master/linux-user-space-dma/Software/Kernel/dma-proxy.c
xilinx dmatest driver:
https://github.com/Xilinx/linux-xlnx/blob/master/drivers/dma/xilinx/axidmatest.c

Using the referenced "dma-proxy" as an example, I'm tracing the case
where there is a timeout. In my "device" case, I want some data from a
DMA slave (DEV_TO_MEM) but it may never come. I'm mentally treating
this as a "socket" but I understand I may have retool my mental
model...

First, this chain eventually resolves into `dma_engine_submit()` via
dma_device->device_prep_slave_sg():
-----------------------------------------------------------------

(~ https://github.com/Xilinx-Wiki-Projects/software-prototypes/blob/master/linux-user-space-dma/Software/Kernel/dma-proxy.c#L198)

sg_init_table(..., 1);
sg_dma_address(... ) = foo.dma_handle;
sg_dma_len(...) = foo.length;
chan_desc = dma_device->device_prep_slave_sg(..., ..., 1, ..., ..., NULL);

if (! chan_desc) {
     printk(KERN_ERR "dmaengine_prep*() error\n");
else { ... }


Then, the driver waits for the completion and prints an error if it
cannot complete:
-------------------------------------------------------------------------------------------------------------------

unsigned long timeout = msecs_to_jiffies(3000);
timeout = wait_for_completion_timeout(foo.cmp, timeout);
status = dma_async_is_tx_complete(..., ..., NULL, NULL);

if (timeout == 0)  {
     printk(KERN_ERR "DMA timed out\n");
}
else { ... }

======

I cannot figure out what to do in the case of a timeout. It appears
descriptors (`chan_desc`) are being leaked when completion cannot be
completed. I see some patches to make the list of descriptors larger
but it appears the default/configured is 255. So if I sit and timeout
for 3sec * 255, I run out of descriptors and that DMA engine instance
is no longer usable. Both this dma-proxy and dmatest driver don't seem
to handle any sort of failure cleanup.

I hope someone can point me in the right direction so I can timeout
nicely. Maybe I need to switch to polling or something like this. Any
information is helpful.

Thanks!

