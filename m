Return-Path: <dmaengine+bounces-3447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D829AD32C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52DB1C21E62
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19021D096F;
	Wed, 23 Oct 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PSs3qb9X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EF1D0949
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705569; cv=none; b=VHOgttV8dVTaQpo8ABPvvqPTXKVj/1J0uGavMYwjwV0QSU/KRqWT+VSDMS/7CbNL3QK8jerUJIpKEey62SjkTyvk7b/VNJ8amBWWP2/MM8GgU86Dw5F66Lv+52mwPGXIl1Ql/Gbjd3GizoAAmWzDWNjR9gTtWWhGI2Pp2SN3BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705569; c=relaxed/simple;
	bh=HhCRM8LXsD648EezB/Ag71ruZTVUBPWIrjPd9FGl4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrp10mIt7e7MTcWAxnSuFa0i1HwdKqnss6/PBjjFMuQReziJxk+dA478p745KK7e3vCz1lGoPbj8r4q23E77yrmR/mjwzedbRyFODTQY2oZHTE5a7cPlALAYlgV8dMCrCPiz9533eilO2+8VVPf+Gu4sr3Efr72mR5ZK6jahoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PSs3qb9X; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so983216066b.1
        for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729705566; x=1730310366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=PSs3qb9XdvpMh5vVZtfIalxzPTqFXxbv83TxWNExgjzSYVTIQiefh/HwMwUj8twfgz
         aci3AVC/5B1+2rOvLnxrDazDZ1Dmz/cOjWkPJuQDK7USJpG8xohkTACCsfNV7w2zNRro
         x+XdnaYeGryiLqnZzcwSeaCt8wFaVzCLs3SnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705566; x=1730310366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=NbwXzsjp0F5KJp2JVs3WgD8Y6Cl4Gq80yOhKM3FWo9oqF6ZjEoNGhKB5MVpzFyuQOK
         mg7+FZ0xbDvz/l3vK7/IBn/KFfv8FCpW23AjzUX6NW/ARkkPWSXuX9yEfevXGo6oVPDg
         eIUOFXKffVjnyv5PBQn1I0S5vKgUTM3uc8NCfVPSasiL9VaWzrVYjev/enNxmKIxsAnU
         ODp1DbSoro6as4hx/bpdtdpM1DIhHI3eU6C97dJnpao/Qk15txiptj6JFLx3Ea4lCLUO
         Zw9c8AViNRoqtC3QSZctt1a/z5wK0WI3tT7FgoYuinv2UJFvQsFUSfjArOmlFUXCTrSE
         iDLA==
X-Forwarded-Encrypted: i=1; AJvYcCUTCQunMt7DAD3fJriuujtWeJ53f3HMgHRM01sWqi0jUZ4F+KpyX2JFTptHQSECmebpuZu/FtnSSTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YbfCXoIR1zU/KE/a0ZvGSkKqJoeur6lAzokPLz6zqVC9ofsC
	n5bA8wIS1nOdb4+rpDWM8ZzEJMH3OJDixiJW0sXso8hfb0O7vQD0xTPCZiOfMVh1bI57JlDmhJ8
	3MwQ=
X-Google-Smtp-Source: AGHT+IGo4fHr9GxAZxZEKaHLqMtDPuhYeMHoYES3SS4jC4pPIHHmN1r/Rv2mU3aY8WRX0v97+hUFZQ==
X-Received: by 2002:a17:907:7d8a:b0:a99:7bc0:bca7 with SMTP id a640c23a62f3a-a9abf84d03fmr332701666b.10.1729705565596;
        Wed, 23 Oct 2024 10:46:05 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee186sm504704766b.55.2024.10.23.10.46.04
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a628b68a7so932103066b.2
        for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJqm25uV6Vw+zRH+PwMJ9s5p871V0yNKQX2FCJiSotUbcD2IJpXhf+U73v+K0zzCKxPoaaHMO6cew=@vger.kernel.org
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9abf94d4b2mr369489566b.47.1729705563762; Wed, 23 Oct 2024
 10:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
In-Reply-To: <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 10:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, gregkh@linuxfoundation.org, 
	wangyuli@uniontech.com, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

Ok, lots of Russian trolls out and about.

It's entirely clear why the change was done, it's not getting
reverted, and using multiple random anonymous accounts to try to
"grass root" it by Russian troll factories isn't going to change
anything.

And FYI for the actual innocent bystanders who aren't troll farm
accounts - the "various compliance requirements" are not just a US
thing.

If you haven't heard of Russian sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Russian
state-sponsored spam.

As to sending me a revert patch - please use whatever mush you call
brains. I'm Finnish. Did you think I'd be *supporting* Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too.

                      Linus

