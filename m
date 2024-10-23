Return-Path: <dmaengine+bounces-3428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73109AC6F2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B59282A25
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8819CC27;
	Wed, 23 Oct 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUtm3nJ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0015CD52;
	Wed, 23 Oct 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677031; cv=none; b=fq3hFqNdKAkppMG2ycxv/MxikqeZUFTHJForIQuDzNoYJm1DBqxIT6QqruxlYXIwTV1SlIMFtUjSnPEClIOuS9MJBUzIAwSuYJPDNCOv6ispAOvjRl0KjHXaUAo0XYekxp6dzK5hgsrT7nPxODolsrpYYWuYavBwjql8zNcCadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677031; c=relaxed/simple;
	bh=nALBb1S+YRbc8EW/CONgUpvGQ1smNeFejUFFKudXFE0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pcQjGX3nmh8ZEMiYZ1ACRWQClUMNhSZKRtaPNVMXgDVdzq0tF0UvUs09DK+NFyUQ2HDEOXE032lr2a5+7AmOxsBmPPWEFiYKMCMRYmRaSOWprZ2AlHXZFbUxrfk9LftGo4cApOP6BzKct8k0lN5ZtR/m13JdV+SqxIAHDpLSxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUtm3nJ6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb587d0436so64094931fa.2;
        Wed, 23 Oct 2024 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729677028; x=1730281828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nALBb1S+YRbc8EW/CONgUpvGQ1smNeFejUFFKudXFE0=;
        b=QUtm3nJ6hpTKalj3aby8q5FemqhoXU+1beXggms+TkNTCMsWtScxw0eV9BhW1CLT8t
         m4AWCUZphwFTHWuwfop3vV8JZyQ98J9R0moJY6uCYZXAndbuYxNDzmoPsaIoqNnURciE
         oUaaKreAA8LMq+7+iRchIh2W+0W4MR4ueEfLAbfCW5llPWavuPpDFZqcYUFahvClxT+i
         10t3oi1+29gqCwSoQbW5bdCvdfa2lF9/VThB4o03WwBWSN9CHs8G6yRZAUdadyctD+EF
         dUD5MEFyaYv5qpvBAiwQuuMrCXqqDR/WntOpr/bev+6crQjqSr0Nue8VYR3mQOwwYz/P
         7cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677028; x=1730281828;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nALBb1S+YRbc8EW/CONgUpvGQ1smNeFejUFFKudXFE0=;
        b=Bg32cN/zKuSRuSSjEdmG8wOo0ovc8aWwpm8PzLGpvSt4QAKMyVVtlvKVTHtYHVtoV/
         Vk8Sc1mXyAbX5tWmtJ9tjmffCzXZxMsyEVCHZVn8KTMcsDEBvW8yF9C1rOs4wJHoixYu
         TZTHmkUl7jBsR0bTqyiDqy0woi5KloNvxA0D5hqmqlrpnnJ5Nn1lLaohuMNYmIpKstMB
         5z/3vzFOdgOzz84GoNMLVacZsaMWgnKoSHJG/zP3JBdJvBKv4pVgMi9AxoEPsKm5dqrR
         G9Zwi74WVUktDH2sUppZafkJ6ERE+LxfV4QEqc/y8pfcCDG9l/bnGhQ5f9sbugK6oqZ3
         PHoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXRoeN2+ehzE7q5SI4pxQA6nRQ9z6zbrFmJFZthdsJwjVcklRTUYTrqQTAESyQ6DH80lnooKF7tu8lqQ==@vger.kernel.org, AJvYcCUadxWcNqdQi5EXGzv0bZauTudrhX9sAV+R4olxD2zlidw4OJOcyiAeb63iAj/vPbktf27cBsTXg1bWIUs=@vger.kernel.org, AJvYcCUsU31fobyL8WdzCWQAfXcRuMGm2lDQrY7Mz2qamFnr1blSsdZy3lXZ+n7Zdb9xVl/MBJ87NQ1ZI8WJYw==@vger.kernel.org, AJvYcCVA10D5BfaJyHRaFnCQHZIvZERsGjUcVX4jT/h8+4WKYcidF0qsZ8DcgmggV/FEqFwpzZ+jjOO8yrz71A==@vger.kernel.org, AJvYcCVS7cONRSha40RB7nyyBt8uDSEpnGJFAfxLncUSrRDePPNcJ4CpqyYS9ie+8rJ6w7S2YFh7fmDpqIRM@vger.kernel.org, AJvYcCVZvrcIHyTelXrgZ545k4KTf9+pXgRwEQhS0mIDRwP7qkjxU924XlrKgAsZ/Zf0bh7qomB9ih7clc/x@vger.kernel.org, AJvYcCVfcLT8Op3m5XJkKylkVtMkmJpUj+VndG/HBap2o3NIN1lcP2Q5SFOf/B0YKLqUDzM9WSTWMQMVY5cQ@vger.kernel.org, AJvYcCVogkVwGgOpj/uIbP7F7+8UJqgwIBVEuJ7E7zzy8GzDpi2fSjlZZBEhox5FZz8BXrpAq/5H3R/zeonumxI=@vger.kernel.org, AJvYcCVqhNkiJ+0HjsoBNHP3kGhj6h6MJM7Zhc4YGtV3QW8poDGl64A9PFlxI4XOlb2rlMhbkrmEcnR/@vger.kernel.org, AJvYcCWZWgCJ6TVY+h785yzUeJ31j1vHQJkr
 VZ6Q8baZZc8+TWAqpEMuzSK6hrg75yoWWo/ui14ziQdYNM4=@vger.kernel.org, AJvYcCXHnSr8MA3EbSx9j7WcS0T8r5k3xFuNMPuKCD0Z7086MExlngN5qY7ozVm6tj7ToMAS98J82+3yyk1WYXIiTuwWt5U=@vger.kernel.org, AJvYcCXSOKs/OXD6sEQps8/xkdKWZ9SXiP0EyEQnIWjBM2992AbXJ70QgVHg3Tr1O/ZxOVZD0xyHJlm0d/4Ji3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAQ66m+AKSgi9jlhbJlUihHAIcJ2xCloDvueyL2rRD1VBWc7G
	K8dnCZuNHZOkkrVC+B9JCoZcWI3W3iZ19TOU0Y+squ6wzF92s4sAf62tZ49SoecWKeGeBSKk/w1
	ob6uNTYTU/wrqAg13VpqBN7kZkLM=
X-Google-Smtp-Source: AGHT+IHNhDNmIBEoWNfMDJkh8nwS8VXu0N87NYNLSWFW58MV9yZik6opYGCLTnx0VgKlf8IbL1v8MSDrZvR16S8jqgo=
X-Received: by 2002:a2e:9010:0:b0:2fb:3e01:b2bd with SMTP id
 38308e7fff4ca-2fc9d35a589mr7818271fa.21.1729677027463; Wed, 23 Oct 2024
 02:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anna Antonenko <portasynthinca3@gmail.com>
Date: Wed, 23 Oct 2024 12:50:16 +0300
Message-ID: <CAG72VMfSwMitWSyBYHF7a3DCJtc_awO4fw=rJkuvcxh-qeqqNQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
To: jeffbai@aosc.io
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, Matt Turner <mattst88@gmail.com>, 
	netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev, 
	patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru, 
	serjk@netup.ru, shc_work@mail.ru, tsbogend@alpha.franken.de, 
	v.georgiev@metrotek.ru, wangyuli@uniontech.com, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

> > Although this commit has been merged, it's still important to know the
> > specific reason (or even an example) that triggered this change for
> > everyone here, right?
> >
> > And those maintainers who have been removed should be notified.
>
> Seconded
>
> <...omitted...>
>
> So I repeat - call the decision-makers out and ask for their
> explanation.

Seconded. I'm no Linux kernel developer, but as a user, I would still like
to know the reason behind a bunch of maintainers getting erased. I wouldn't
go as far as to claim that I sense malice, but there's definitely something
fishy. I would like a proper, public statement about what happened and why.

