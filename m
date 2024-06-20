Return-Path: <dmaengine+bounces-2471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54696911229
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A6A280D7A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FF1B9AAB;
	Thu, 20 Jun 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQI1wqrU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471261AC765
	for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911973; cv=none; b=s77cpww6LN8QZq7CiVF0u4GY1xKHSIleFEDelOg/VNrP1AKtHgdCGk1RDULmutIKEKPtg2dFzXdqa06iPeK5DyNIYvPV8eQckvJQJoP6Cr0exjUqjjjXe2MV4EqrgP14acnxcGKPj+P22zU1RlsHJPSjAKCEf9DbTS5Mrg0AeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911973; c=relaxed/simple;
	bh=LMJhwXKqZKwDoZfSA47gsl66tl0ZA7Fm/pP5alDoprs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBJcayNjXu/DinDZqgiVtUuNQDDWBFY9tBV0OO3wGSMPV+eXObE/LCnHaQvYNO/l8iu8+QlJOfCJ9wG3f17qru77ynjEqGbyAqHIX3Q0vW7ht/Shni5lDoo71XGJuDzBvtdgHTsHQcYi5xId9Ef8VYEno2Dito5CeoKNMSrTzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQI1wqrU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso869515a12.0
        for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718911969; x=1719516769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=TQI1wqrUoBJyNke7b+5r8pXDrs317pP8bFozr7Eu/6H6uH6RZ+UMSIV4eM1zkrLXq3
         Pyahg2CgSciDHmePK2TmfNGqL1wTQJYAgZVE33o8zIpSXF9lcix/wtxrRMb0kbeq7mcW
         yMLJYMFnPE2mH6vJS64eusYDUDF2n4ze+2q/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911969; x=1719516769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=Z9uomAZ4g9tpxqq3ehWPxc0C6RInX0Owyb2+dU13wIt7UA/ieA8RdREnqDTjvCkK7a
         tBqcIDpnlhKBObAab9ErLBYA2znfcalcgnWz2tiQ4hBG1EN0qFZDsUcmgauXvRCDKyH5
         QDGES07hHMMuX87VlEQF8YCuj5tdToX87AAwII3ihGEyFsMdZUc/++8pWurAa1Xkb1Rk
         ek8mNJQWT4W/gnT+u1N5FtRohXLh3og+W/YHyAeKD2RMcE9+AINkLPg9dg6R1PqEik8e
         J8kiie4NvA9HznaMFqJYKxDY4+af5oZXAa62VoqRIhG+LJ2HyNYeaKZPzu4UDduQhGQp
         KVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS6gRc43GDFH0S3TieaRqJ84b/Z+46cdrd5Scz/MeWDi31CJWTF+6D2UBDIKFzcRJB3ihCICqMoCjEPZHlRTcsF3zNy8aLeZzU
X-Gm-Message-State: AOJu0Yym6U0Z5ydYatXPz/ZCGcgTcdfaVQWTjwdUukn6oLbeBId7xQUg
	HR9BmzwC9T5cIv0wwPv5ifp07AUbBnhdKtbB78h+yN6AlKb/0UzNJgqmTNbK0eIU1tO3jN/M04H
	tDunHynW1
X-Google-Smtp-Source: AGHT+IG8/L2vO0gCjz2AyESJu3VZIpBMGm/vKfZ4zEErNFhcj7zQs+9pH92aJ6uT2w0v3JCRNrW+4g==
X-Received: by 2002:a50:c014:0:b0:57c:935d:2881 with SMTP id 4fb4d7f45d1cf-57d07eb274bmr4663606a12.32.1718911969468;
        Thu, 20 Jun 2024 12:32:49 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e96b4sm10264035a12.50.2024.06.20.12.32.49
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:32:49 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so992470f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 12:32:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFjvcToTrKVgXUX5H2c0ZYiv4SYM2lLkgdpWqop1f6gsjnd/rzr/Chw9ZqDan2pde4+iDgGAJQM1pNetTdLLBQDIyese6tvD9m
X-Received: by 2002:a5d:6152:0:b0:35f:308a:cab0 with SMTP id
 ffacd0b85a97d-363170ecbe5mr4379764f8f.13.1718911595412; Thu, 20 Jun 2024
 12:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad>
In-Reply-To: <ZnR1tQN01kN97G_F@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 11:32, Yury Norov <yury.norov@gmail.com> wrote:
>
> Is that in master already? I didn't get any email, and I can't find
> anything related in the master branch.

It's 5d272dd1b343 ("cpumask: limit FORCE_NR_CPUS to just the UP case").

> > New rule: before you send some optimization, you need to have NUMBERS.
>
> I tried to underline that it's not a performance optimization at my
> best.

If it's not about performance, then it damn well shouldn't be 90%
inline functions in a header file.

If it's a helper function, it needs to be a real function elsewhere. Not this:

 include/linux/find_atomic.h                  | 324 +++++++++++++++++++

because either performance really matters, in which case you need to
show profiles, or performance doesn't matter, in which case it damn
well shouldn't have special cases for small bitsets that double the
size of the code.

              Linus

