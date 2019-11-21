Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA1104787
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUA14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:27:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40763 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUA14 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Nov 2019 19:27:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so1345286otq.7
        for <dmaengine@vger.kernel.org>; Wed, 20 Nov 2019 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRno2ndEL0aLy2ekCq8SNn5kziBB2zvsTzrFr0XgIgU=;
        b=UsxjVTviHd1kq3bZY0wQXN4tO71PI7wZsg8+pSSo6kwk8/8EHAMXGv9vdcs9hutQlP
         0leGxb9TacCeXprtwZiY3xsNY6gripp3Qc0tIXxhZ03aDz342HV0mW2x1q45x+bl6UWA
         VWJcMEKRUuHcLh1HZqqGctCaPdfbNFp2oLVjWSy0iWOfjwd4XhDxBMIP/lKIc3a7p/fF
         Y9NVorH1XEf/AfhzqEc8Ntbk1sS/Ox85kDbjLyXyR0BZ8Vo/WfNmRdG5MlXpopfqVJ+x
         dF64g8ETXHgomru5gvKmhahhIoBkVD30oGxPHoUxpVLudN14DWdVmlSpXrAs8wQDJWAL
         J9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRno2ndEL0aLy2ekCq8SNn5kziBB2zvsTzrFr0XgIgU=;
        b=VHqeGwDQQlLfBmx66dKqfXXSuUHLq6Jmsow68cGic/lH3QYnA8wrAIKEL2NoEyzB/2
         Tt2OVXvRYAa+WAysDLsdfJLe5phj+A36NEuS9jTNT80JY3DQgGbdZ2apn73LVFPPZx4q
         ocXGU56tmDBf48ljF0LcU014ZAnXNgLbKzGNrhbwhJB6mgWgRzZtMYwQ6kpFmVbJCZTi
         DnFSAXw9J7/vrTKPh/qyW8NZO6WuG7cH30DCUM5qAk+1i4EwDJF1wcA9FG5I/atLUi9u
         fnz//Eif6RVbiE9bVj8k7aClyifJl+Z7gwVLvHrg7C/vwgdrVb2BNXwUhz1Wtu9ksuT6
         NL/A==
X-Gm-Message-State: APjAAAWIjCGD0QAVnktCLfyYi3Syf3tRORgV7ljTfu4i6YiahtF07usO
        PLIJjFcWKQpmzpwplpCND+ZW0igfDFF/CrRu1PM9cA==
X-Google-Smtp-Source: APXvYqydVUCALCV2gDjSgpUPjbBj1Jy2nVlG6eMJ9zJZGgKne8uQD9fRLPiO5DU7wqHm7+NmtFxuyY4SSgF+oSAxO8Y=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr4139129otb.126.1574296075328;
 Wed, 20 Nov 2019 16:27:55 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic>
In-Reply-To: <20191120232645.GO2634@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 16:27:43 -0800
Message-ID: <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 3:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 20, 2019 at 03:19:23PM -0800, Luck, Tony wrote:
> > That's the underlying functionality of the MOVDIR64B instruction. A
> > posted write so no way to know if it succeeded.
>
> So how do you know whether any of the writes went through?

It's identical to the writel() mmio-write to start a SATA command
transfer. The higher level device driver protocol validates that the
command went through, ultimately with a timeout. There's no return
value for iosubmit_cmds512() for the same reason there's no return
value for the other iowrite primitives.
