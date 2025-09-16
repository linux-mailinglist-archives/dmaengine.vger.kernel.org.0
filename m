Return-Path: <dmaengine+bounces-6526-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F6B59265
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4321BC1A9A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C3296BB3;
	Tue, 16 Sep 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dglkp5cU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B901E47B7;
	Tue, 16 Sep 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015524; cv=none; b=eUMeC8FqeVTD2pbuTKQn5bVfiaOp2d6N9nKxi/X7XxUqq8vqijdMolL4FnbHDGrXpVKj1F6acvjOim75FoD3+FVg2mjdFRiPMgGCsTrU6s/WEkctG8ZGL/RPrscwFSK65HZt+IUp0ZvufQ5beuwaX4bGfLSEwXtoZxjtaARAp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015524; c=relaxed/simple;
	bh=o7be88KCadyNySjrHcGf5VEDbfv5f6IvB8nMTochL2M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tlNQI94rVHZ4rLtuTvi3WMZUvAB8atUlZ7/IePdZ26l05xFD2/LBVALC56+R1urAtckFuKZVRihcXS1DLuOkjuR7UpbL8Sz6cYAf2DCfrHlEuaVffrweul1RfvLFEdGHtP3Abmz92QaniI7ILyFQZYPvhT7IKYIDtFWCNmtmz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dglkp5cU; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758015493; x=1758620293; i=markus.elfring@web.de;
	bh=o7be88KCadyNySjrHcGf5VEDbfv5f6IvB8nMTochL2M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dglkp5cUM1lp073pcbUha+l8F+nk8mJf5Q8FM9zhXR03gcfuEFkkjWLhHpZldk5y
	 jdkASVxfy7BHRxBv7hifxf+MdBAZQWepNWSPVhjincOSQzFoKSdGFNIQ5ePW/UCBT
	 hWlP9wRn42FotCppxbrIJFY4FUV0Jpg0PI+iJdCTHe3SS0P7rLz4Cimuc//jqOJFQ
	 on0jjGI6vWTzMpDlg8lWnO8qoCuL5JZATPh6cWmvbMj4xjNftiMYRqpMhDmJ/eN+P
	 dZZgWWeg5k9baAG6dgXn2eSW9/N9+YL/xY2OrnSG6L5GkaPUclBhPc9rKZKdj87Qq
	 kb7MQcQ6pFSe99IVyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.197]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1v5rCa1uxB-009q7E; Tue, 16
 Sep 2025 11:38:13 +0200
Message-ID: <63a87cb6-5859-49a8-9f3c-151a962085c2@web.de>
Date: Tue, 16 Sep 2025 11:38:11 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Lynch <nathan.lynch@amd.com>, Wei Huang <wei.huang2@amd.com>,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
Subject: Re: [PATCH RFC 05/13] dmaengine: sdxi: Add software data structures
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CmVZ7CPUDPkAlAecGkMSR26FIlA1QdQ4eo6/RWnL/k2zTu/dMQY
 UIZsMhr9j0vWAr7QT4nJJdvPw88mj/aM947nw7lAiph/cUn0UDwwkIabV6ViTmzAvrSZVSm
 Te6ZtP3CawK/lniijuF3JF8bHUPqCsMAdiByOor8C7uFHIpwG5eiHe3AicNw6/FsUFQP6Bi
 MJjsg9UuakBM5tOwE1bSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vqkKoeQThf0=;Rt1WGNXvjuvUg5kBPy0D/I3cyJc
 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

=E2=80=A6
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SDXI device driver header
> + *
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __SDXI_H
> +#define __SDXI_H
=E2=80=A6

Do you find the usage of leading underscores still appropriate for such an=
 identifier?
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier
https://en.wikipedia.org/wiki/Include_guard#Difficulties

Regards,
Markus

