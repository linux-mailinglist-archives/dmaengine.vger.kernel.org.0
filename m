Return-Path: <dmaengine+bounces-1789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181C89D0C1
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AD41C21FE7
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A713A3E5;
	Tue,  9 Apr 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em0HzBlN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D113667A;
	Tue,  9 Apr 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632199; cv=none; b=FivUx5rJh/3YNTIBT2V9x0SOCAdA/tPAACu4n7YP23wJvy+wVm7yu4LASRN8JtiicgzedU0VwtM/ZEKIkCtsPisRTogYOecBx1Q2HAwjfpqsQRZPo5nxJkCnF4UkK/ghUEeYxa/OJojlnqp9ukScLmfazokIazBPXCmMPJhMBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632199; c=relaxed/simple;
	bh=1nW8c6xT4xjuexdsl7iCzukkDNi5qw9LiQWUF2euC2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huy/ip00sINO8m7AWRuS7S0uqFPWqbY0RT94ydQMB2Su1PmdhJobaBaSg1a4+L0VK4UZK11SMm7H6TIHf+2agTl7Q75alaWFPsuneuqt6mfXHiMOCXqjfanQTBULiqSsft/JibUMf4K7zmjqmYUx7Eg9uYuIjhfy4imzP1+ylQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em0HzBlN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so63766671fa.2;
        Mon, 08 Apr 2024 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712632195; x=1713236995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76vHKlkPl4zx/sYpnGb1W+utnXEMWzAaVqU7pqKDMoM=;
        b=em0HzBlNNcYyRGI0y8zH8qZeINHUbmPAdhNsh4aapsr5NP10kZv6vWxY4fi3vvc8op
         JQsvCuzQBY6kL+VcwWi6+1ajvNCmpiEuj3Pr0bAYN63gEvLkX4fvowCJ2ugZRnbz3kPv
         JFn9R+5alnF3dr/PQ2EQroFlZq0buRf2359T9mzBHKclQQYo/I2lJhsMcusMz6efWNpi
         OBnWbgUZ95srkZynKX/ixiqRQPW9PDJFwA3eKBK7XBrDIAGyiPJh6Wp87YOjmjiEZgKC
         wqVbPto4UJziyJrhya8yeWRPlGAc/l8NYoobT+Qf8YFbl+hMsK75VVd53hNc9PjOw5kr
         P38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712632195; x=1713236995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76vHKlkPl4zx/sYpnGb1W+utnXEMWzAaVqU7pqKDMoM=;
        b=ph5CFMkIUJL+tE2UHJ03g9b0uP9y/cmAXabxJrchlpCYJvJoHZwvunZEpT+30Nrfuu
         XM0CMAHqBtmusCv4BLfG8j1AY0AsLZk5+ZPy9wMgwD7PiqMksDtjcF3yerGtIwt4iCAT
         6Tk04dEQtHBqXOx593AD7+Qx4ZF+lG75QLpiceK1yPtxxp1OUIWHVv1E1DML8D3FWTz+
         nsl+ZPUkmBYt05qIJWQUI9HxNfdyLBYFL8H2Obf0wMQGTfjq0XMrFSRrh+0tWfndDOdP
         IWY4DbMmq+aQUWiZdNzyY3vFq+sqFUC3UmGQ0JKGs59ZHxHpvEYUcVW8SEmKyrePXZ+Z
         Kevg==
X-Forwarded-Encrypted: i=1; AJvYcCVhqxVwdJz8nhXfzVwQnrvwX4T8NUfjsTv8BXDtEGb9JxfYMcYDJIDNn4oc7cHsW+juZGDTl8LWmc4Lvd3jm53u9e+LqQiiQzjXSYYV
X-Gm-Message-State: AOJu0Yxt5lyZWjcVWdo9GajRcwRfjBLC/peYXcqdo2dBo6HX+jo7RgMo
	EA2yiLPiczfTFFOFkZLuRWqDnQ5IGFivwgAKPc0HdyuUKDqYvkUu
X-Google-Smtp-Source: AGHT+IGmRB/BC2yOHt7fRFzbdYyTq9seO89uvEloELayi2NgGXi/YJWpnhfFRAoWc3SxuJf+69cmAA==
X-Received: by 2002:a2e:8857:0:b0:2d6:b424:a634 with SMTP id z23-20020a2e8857000000b002d6b424a634mr7655712ljj.15.1712632194893;
        Mon, 08 Apr 2024 20:09:54 -0700 (PDT)
Received: from freebase (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b004162ce49719sm16530113wmb.6.2024.04.08.20.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 20:09:54 -0700 (PDT)
Date: Tue, 9 Apr 2024 05:09:52 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Eric Schwarz <eas@sw-optimization.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
Message-ID: <ZhSxgAxCSeekTdNT@freebase>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
 <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
 <ZQyWsvcQCJgmG5aO@freebase>
 <8d18106d-444e-9346-26cc-3767540df5d8@sw-optimization.com>
 <ZQ3B9NWVmLvaVhJX@freebase>
 <5e2404d4-f36c-7718-c0fc-d226aefdf2f6@sw-optimization.com>
 <245a848c-5bbc-463d-b7e1-b82cea2c4dba@sw-optimization.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245a848c-5bbc-463d-b7e1-b82cea2c4dba@sw-optimization.com>

Hi Eric,

Changes were tested successfully, i will resend v2 soon.

Olivier

On Sun, Feb 25, 2024 at 09:05:37PM +0100, Eric Schwarz wrote:
> Hello Olivier,
> 
> just a ping on getting the patches / fixes below mainline. - Were you able
> to get hardware for testing?
> 
> Many thanks
> Eric
> 
> 
> Am 28.09.2023 um 09:57 schrieb Eric Schwarz:
> > Hello Olivier,
> > 
> > Am 22.09.2023 um 18:33 schrieb Olivier Dautricourt:
> > > Hi Eric,
> > > 
> > > On Fri, Sep 22, 2023 at 09:49:59AM +0200, Eric Schwarz wrote:
> > > > Hello Olivier,
> > > > 
> > > > > > Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
> > > > > > > Sparse complains because we first take the lock in
> > > > > > > msgdma_tasklet -> move
> > > > > > > locking to msgdma_chan_desc_cleanup.
> > > > > > > In consequence, move calling of
> > > > > > > msgdma_chan_desc_cleanup outside of the
> > > > > > > critical section of function msgdma_tasklet.
> > > > > > > 
> > > > > > > Use spin_unlock_irqsave/restore instead of just
> > > > > > > spinlock/unlock to keep
> > > > > > > state of irqs while executing the callbacks.
> > > > > > 
> > > > > > What about the locking in the IRQ handler
> > > > > > msgdma_irq_handler() itself? -
> > > > > > Shouldn't spin_unlock_irqsave/restore() be used there as
> > > > > > well instead of
> > > > > > just spinlock/unlock()?
> > > > > 
> > > > > IMO no:
> > > > > It is covered by [1]("Locking Between Hard IRQ and Softirqs/Tasklets")
> > > > > The irq handler cannot be preempted by the tasklet, so the
> > > > > spin_lock/unlock version is ok. However the tasklet could be
> > > > > interrupted
> > > > > by the Hard IRQ hence the disabling of irqs with save/restore when
> > > > > entering critical section.
> > > > > 
> > > > > It should not be needed to keep interrupts locally disabled
> > > > > while invoking
> > > > > callbacks, will add this to the commit description.
> > > > > 
> > > > > [1] https://www.kernel.org/doc/Documentation/kernel-hacking/locking.rst
> > > > 
> > > > Thanks for the link. I have read differently here [2] w/ special
> > > > emphasis on
> > > > "Lesson 3: spinlocks revisited.".
> > > > 
> > > > [2] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
> > > > 
> > > 
> > > This chapter [2] says that our code must use irq versions of spin_lock
> > > because our handler does indeed play with the lock. However this
> > > requirement does not apply to the irq handler itself, as we know that the
> > > interrupt line is disabled during the execution of the handler (and our
> > > handler is not shared with another irq).
> > 
> > "... as we know that the interrupt line is disabled during the execution
> > of the handler (and our handler is not shared with another irq)."
> > 
> > That was the point I wanted to be sure about. So if the IRQ handler
> > cannot be called twice ensured by architecture neither on single or
> > multi CPU systems (SMP or others) I am fine.
> > Thanks for your response on that. Appreciated.
> > 
> > Because you take the effort to set up hardware and environment again you
> > may also test following fixes/improvements from zynqmp driver which
> > could then be merged into altera-msgdma driver. Please check yourself:
> > 
> > f2b816a1dfb8 ("dmaengine: zynqmp_dma: Add device_synchronize support")
> > # Caught by your patchset
> > #9558cf4ad07e ("dmaengine: zynqmp_dma: fix lockdep warning in tasklet")
> > # Caught by your patchset
> > #16ed0ef3e931 ("dmaengine: zynqmp_dma: cleanup after completing all
> > descriptors")
> > # Caught by your patchset - For the altera-msgdma driver it is a real
> > fix not an optimization.
> > #48594dbf793a ("dmaengine: zynqmp_dma: Use list_move_tail instead of
> > list_del/list_add_tail")
> > 5ba080aada5e ("dmaengine: zynqmp_dma: Fix race condition in the probe")
> > 
> > Note: If the sequence is applied in reverse order the log would be
> > comparable to zynqmp driver's log.
> > 
> > IMHO your patchset could/should be extended by two more patches and
> > split into small junks as mentioned. Then history would stay intact to
> > be compared to zynqmp driver.
> > 
> > Note: Take care about "Developer’s Certificate of Origin 1.1". IMHO
> > "Signed-off-by" tags from the other patches might/must be copied at
> > least for most of the patches then, which would make it easier to get it
> > into mainline.
> > 
> > Btw, some cosmetic changes could be made in the mainlined driver:
> > 
> > 30s/implements/Implements/
> > 31s/data/Data/
> > 32s/data/Data/
> > 33s/the/The/
> > 39s/data/Data/
> > 40s/data/Data/
> > 41s/characteristics/Characteristics/
> > 109s/response/Response/
> > 154s/implements/Implements/
> > 154s/sw\ /SW\ /
> > 155s/support/Support/
> > 155s/api/API/
> > 156s/assosiated/Associated/
> > 157s/node\ /Node\ /
> > 158s/transmit/Transmit/
> > 259s/Hw/HW/
> > 291s/Hw/HW/
> > 322s/prepare/Prepare/
> > 327s/transfer/Transfer/
> > 378s/prepare/Prepare/
> > 384s/transfer/Transfer/
> > 385s/transfer/Transfer/
> > 502s/its/it\'s/
> > 514s/oder/order/
> > 530s/copy\ /Copy\ /
> > 680s/sSGDMA/mSGDMA/
> > 723s/Interrupt/interrupt/
> > 752s/\(\)//
> > 921s/\(\)//
> > 
> > ... and another patch, if that is taken into account.
> > 
> > Cheers
> > Eric

