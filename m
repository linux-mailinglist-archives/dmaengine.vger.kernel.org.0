Return-Path: <dmaengine+bounces-2130-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7BB8CB355
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7089E1C21AEB
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9A130A4D;
	Tue, 21 May 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="POYSuY6x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085723775;
	Tue, 21 May 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315161; cv=none; b=enOuGY5r4LVU2N3AHAE07qCXPJ288Y11qxh8z+JMGUUX7VptFAyeWGthK9yiYPPBm87/Yy09Ty7/6aaHkyNcynQ3xVI/S5BFUbFN9CSumQb3LajznCvMf8rQ96cZGuFlmnXG+nVmtmOF9JTDTk60ld060XPDhDkEzXMiBecgaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315161; c=relaxed/simple;
	bh=lf82Yp3ydu6DM97xYh1vKVTtqdtWCK5RR12EMBbDS6Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=duaqneCmlMLy+4NlE34DyhuSWk7bQ/CnZ6gxFHx2eoKCraN63cFf04Yk3HMaHwBftovo16cjF9YLBQvzgv6vkKikKR+r/C7yIn23tX4Ciepe66FZAMHSdIMrL5QKYfQpBOqaol79f1cTbAlq3ue+KDe86RUhkOExYES6wEQ/wUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=POYSuY6x; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716315133; x=1716919933; i=markus.elfring@web.de;
	bh=QXLk9GW3AZRa5cO2vjuK92/gTK3vLURS16p8QBvrT1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=POYSuY6xYq1cK1SiW73JXtRSkU4sbUJRxe9OGzP4lDyY64O9jSb4J1nlcNirB/Vm
	 vXJZlmmRGt7Fa3zGNWw+3bsU2jf2Zl1jKokHQwmAEe299h5puXfElDcjvO/j5A7MQ
	 QEf/aUE7Ta9qZsARjy+jiVv1bzQo0T8JOKUDg367XGC56/W3xVlYw1QY2EuuKEUyM
	 gsKhQKexWWmEVlF9yJeKZtR4eiwOMV9WsUh8NAVEactkCHaZZDupJ5ybdYCT+pBea
	 O9ZevPxXexi+t1F1cVsXt9e/PTaUdoeDvk9W8GM6zafQ5ae4C+ZDyseeQrUBFFODS
	 wh/D9SpiIyokBMXuZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1ssi8G2c97-00gnPX; Tue, 21
 May 2024 20:12:13 +0200
Message-ID: <22a66571-0a0c-46dd-899a-d24079372880@web.de>
Date: Tue, 21 May 2024 20:12:10 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Siddharth Vadapalli <s-vadapalli@ti.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sriramakrishnan <srk@ti.com>
References: <20240518100556.2551788-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix
 of_k3_udma_glue_parse_chn_by_id()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240518100556.2551788-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9lmdupZcs3XCCJzzfHYI2egHuwYPLtyAA7qGq/AVpL+Zct3/2e1
 bee3fcCOSrHuejaoIpqUyRRytP/ZCG7C/HaVLr5DnjXeWMARWlRbBj68sFqGJelRDA5Ho28
 TGxZjZyFBVfMJBGyqrLsC2G9Tg8Gk68Arotc3+cXBNFAHQaaLfwUCywSDXqChhfcUkfXw5P
 FG/O775JoHGePDMGE39dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HuWJkkP3hB8=;qiRgh3yaJibcIOkXQi0sPZwLSPk
 L3WzUhd8/0BIxZB9ODig8ZjqIHkKQgqkwhT0mAYL93maxQDFcs+eUDbpBPvH8PaBLUY1a0OTk
 kW3TyrkNPpz61O+KMlAcPF3ZuUiCsNNAO/8IXpCbB4GguuJGyInuS1r2eOCwFR0nnSSfYS5bB
 4DqFrhUbtbRIFdgk/z/lzv++Bl6TufXtC+/fMb0xXcsPZiOWAQtWjzt0TnjmCll7uDigfeBD+
 RmP+7OgGycT/0ex5GDWtpkbE5YeadyExW1Kx6LER2+TjTFiYAwO9fLOavriFHgxXP66raQfCX
 GKJXeyyDpH7Jshl/njK0WAhSEdNyInBg6K5sP1g2AydY1QqS9a/r8wYuteDk27IuFfGa2SyM5
 QGNabfGQBl9njvy2udPgvPW68E3AuEVA7npvqL7R91iEqhMa7lgG2abG0qyq6XJX+rKjb/hvT
 VVQBe+gXsD5P6UUKW3DfevBss7eY3sUZIkw9e+SCcDBFwjPLk1JDv2vD0bH2tL5v+SorP9Wxp
 dJgNg8wwZkDOWGLB9h3nV69tlhGCcSwibLtdQ4010gZ6KhLnG3pPoFEDoKo25xF/Lrm+leVm6
 r3AIqPS5p57XjkOh7U/220iSsuitovp/FHldwJgxQF4tnV1EGaAzOhrxhgrSbSLwO1+pjnaOj
 ENxS2mlSkkhQWJqHfqpQFJhsbhzefKVE/RFtpNVKasKwI5I1wwhd4IFYbugLO4z8GYvOWr+n8
 qVnfMOT3EDVvxqIoWsrKe8aZw9OK3/Y0ucLyhamIHJSx2V77yD1XRGklDW8qMyUroGFx9vxDp
 CP74CcLsJjGkWJaDZKowp341uUmQqVQe4g8zc6I9oVp68=

=E2=80=A6
> without having incremented its reference at any point. =E2=80=A6
                                           counter?

Regards,
Markus


