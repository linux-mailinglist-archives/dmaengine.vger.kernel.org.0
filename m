Return-Path: <dmaengine+bounces-6860-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F414BE3308
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B17480012
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE431CA5E;
	Thu, 16 Oct 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8M+ypII"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5231AF34
	for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615554; cv=none; b=CU+CaZX9ecYg602TXFSJwXnb8TX2xPpl6Dhtnf2h5iNKrgSRO4l2l+BxA41sWks5RG/yE4WpPASEQTvd76OaXOhOhsKTMVaktvzuF7rm0ZUPVdiZHdR1GJFfV0w4g7ij2a+tuZ9TEC444enLnlTRNjodEu+5/SfyfzqCz5K5vP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615554; c=relaxed/simple;
	bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZxWIr82Xaa2PaFI31UZpRslEUInGxVHGIBh1WZSxd2XtgD4wW/RqKUj0BsPNhNaC/Bh2vcC9CEJkYR6N7B9V+XqL4Cui9tTnU8GlrMeVGybPWfNFTNWoMXzMJBKJD0Tesg/gEIvfkxtmgDfWGelVeCrBOz3OfdCz7YDIKFDe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8M+ypII; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-651c646b857so48566eaf.0
        for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615551; x=1761220351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
        b=M8M+ypIItBI7oRThWFl4sOdAJoXP6jcdl+tQ9PtmRACAEJprF9ihfA2WRBjumA02M8
         XhI8WpisQIPABUk93jne2TcGkjnnCUyK+0V82itEbTEUgHMSy/6bVnZvr8ggvG4W7AWy
         9wjxuRjKkgzmW/OSczTylqNDZpqMHW3IQCaxMMOR7PYZ+7HbhAWLWZ5Bapfefb3Aw8qv
         4ycVv9GWWFlnfj1vHiiCrPN7QMPUUCXuScAHx9ZG/FSYwFVju1oGS1sp5/eg8qBprCqQ
         gXrbTGNTZkwy6oytA9gYElOhy39qOso2y/6mhLcXn1TI+5wU55xDPmPH6o74+X0z3ZvJ
         kKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615551; x=1761220351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC+9tDBrABDE/IJ+3G93YVagmcCQSUndMoDjtVKH8do=;
        b=UM4abc3WGj+0Y0LpMCEfNQeVUckpCoE8kPyUM+df4Z93kEgt5cGIsuGaGkQWQbpO0K
         zDaY85RRzXGTGtVo7w+JEPgD0NiZMbQwsDc95w+W2WNg5WL5nrraBi+s01ko7TXi62jE
         fW6qiHm6UJtuUtcopI09YS+twYvSHMpwkUdz2M6sDN4nV/EnNKV3XiZE+4Zxm5gdPmEE
         o5R19UqVKSQkI79RwMmk7j20VWdoq6AeoaSb5W2xmv/mFi8u2XpQYh4reImJLPze6Yw0
         sgwNYrcjsIgR6Nt+jgTda8o+ZoR44xb6zyjPvvWgty+XZ1OOAqaLS8RuVlV1M4eLiev2
         iJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCV65N5EAF0B3LtvbcoPhksC9hMnHyxJ6TZ73dLbSqs+KpWOPAl3RMn/UTY8Sm8w79D5Na/s8EnmwMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeZH1b8PIYFa7ErrG8fctkZbMNYeCff3IoHXs34WjihrmIWT2
	/9TBRcqdnvyBwqJf8VGFnPmYa0ij7IBdQrT09MhV0V8beu9RJ0MJ+mLT/mzrIcLwg8IyV2af/FI
	Dj42qk/kPKspXFoUi6Z5dlq0aH+5H6wH93w==
X-Gm-Gg: ASbGnctVcejALwGhgipyXuT0G/a7pDh3f2+E23PXf4i05QfHNAaRI/RsvyTvrM9TiZ9
	I7eoCAgcrmMzu8n80j9LRaKVDurGU4cfMHhBKFiv7Q+Lpo6bZsE24nUC855Yi0vIH/0FTurgvOA
	qUrU9kJo46VCFI4gGeSHY8KiXxMVy1+7QmtfMyJfuRx/vLszr7YSLsQ6jwYySz03DYRxLgfDIm6
	yUW1jR+5WXyy5Z/D1pIPhCZT4xrtdhiq2Gn8H5cmQgLtDW79A5bjMx3i7BSNQ==
X-Google-Smtp-Source: AGHT+IFauwwQS3WETtyLhzy44iD48OMfA608HyRDHXmXr5xDQLt9tlht985FKph/VCC9SYR1RyZpln3F5+TQqJplHjM=
X-Received: by 2002:a05:6871:81da:20b0:3c9:7398:51c0 with SMTP id
 586e51a60fabf-3c97398642fmr902024fac.31.1760615550975; Thu, 16 Oct 2025
 04:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185645.yhrtn64mwpfom7ut@wrangler>
In-Reply-To: <20251013185645.yhrtn64mwpfom7ut@wrangler>
From: Karim Manaouil <kmanaouil.dev@gmail.com>
Date: Thu, 16 Oct 2025 12:52:19 +0100
X-Gm-Features: AS18NWB3B3V_JmGbFkguEBUx1ZHqqCPVgptVO3r8ni_Q_BkPMq6dhfTbp54BDYA
Message-ID: <CA+uifjMUQS+nkaDqGnm77tLG38k9ZYi-mcF2eqpOKHnaF2Nvhw@mail.gmail.com>
Subject: Re: Which amd cpu families support ptdma and ae4dma?
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Nathan Lynch <nathan.lynch@amd.com>, 
	Sanjay R Mehta <sanju.mehta@amd.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey guys,

Just a gentle reminder. Much appreciated!

Thanks

On Mon, Oct 13, 2025 at 7:56=E2=80=AFPM Karim Manaouil <kmanaouil.dev@gmail=
.com> wrote:
>
> Hi folks,
>
> I have a dual AMD EPYC 9224 on a Gigabyte MZ73-LM0 server motherboard. I
> am trying to use ptdma or ae4dma to prototype a memory management
> related patch, but it doesn't seem like any of those engines exist on my
> CPU. I loaded ae4dma but /sys/class/dma and /sys/kernel/debug/dmaengine
> are empty and I can't see anyting on dmsg.
>
> I cannot find any documentation whatsover online on those engines.
>
> Could you please tell me which classes of amd cpus support those
> engines? Is there a chance I have it, but I'm missing something?
>
> I am on Linux v6.17. I also tried to check with lspci. It doesn't seem
> to report anything related to ptdma or ae4dma.
>
> Any info will be much appreciated!
>
> Thanks
>
> --
> ~karim

