Return-Path: <dmaengine+bounces-4373-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D7A2E5D4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 08:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F9188252F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97C1ADC93;
	Mon, 10 Feb 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DyFh8jMN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E222F2A
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174105; cv=none; b=OFJTJ2IwT0dU5gTw5jvwaxRCiP/bMlfugxKAZT5CDPObmcB6JA94d+zzKSXO4tctVA31xpnhrrvJ+csvEH7IGL4IwjKlC87fiXMlAeoE5fsO68grOVHFxGHPEzBCSDtXePUZXOFjpNomZBT9gdlZAVSVjPGKf2UGn5RdvfvPQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174105; c=relaxed/simple;
	bh=JomylP+Fs6SJyqj2Jc4h+BAK20Yu8IHbZLtFviRNntM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=LFalsnW5vxUZy8d1IvKRTNY9lBHa5i1gl7yJ5AW5bNyJ02lpK7jzv3N2OpvY9kHc6AYXPpmWrb3mQGBNJFXmvah5VMuUAnB6H7dQn/iszW0EMeqSgF9s/lH6Tg4quAtEtELW9WU2teIAcMbFvSA7lLeYz2bk7BFI7YCv4GRpeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DyFh8jMN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250210075501epoutp04d0da8c806bbdb1b85813b5090d5f8c26~iyaFs9JcR2383623836epoutp04K
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 07:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250210075501epoutp04d0da8c806bbdb1b85813b5090d5f8c26~iyaFs9JcR2383623836epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739174101;
	bh=Kjo+EpNxKONxJbmDV6xPmrDu62bACw6LLEldMcvmQzo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=DyFh8jMNtMwddJLEJ5FEkkmYbnsZyk5Vcep1M4Z+Y6g5Fy9zhqSSO7v37VQ7aB9G0
	 jE93jEIVZhtljyt8A8rGkN2TBBXl9fy0PKIQagwNUZ8a8lMCjsGiXp08GoeepXIuCA
	 Ww4b45gt5PnBuhVIw1v0YCVI9A/lC7FWJdSrSFKc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250210075500epcas5p2531b9376732ad53cbb8909b4bb8d4d63~iyaFYDPhG1889218892epcas5p2M;
	Mon, 10 Feb 2025 07:55:00 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yrxgl5TXdz4x9Pt; Mon, 10 Feb
	2025 07:54:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.C8.29212.3D0B9A76; Mon, 10 Feb 2025 16:54:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250210075459epcas5p2eb0d4b6916f999e7c98d7e869e2d0ad6~iyaD7Boqz2130321303epcas5p2e;
	Mon, 10 Feb 2025 07:54:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250210075459epsmtrp2eeacef6f877ae1ee64f33fb74fd7bcca~iyaD6UFgG1951919519epsmtrp2P;
	Mon, 10 Feb 2025 07:54:59 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-c8-67a9b0d39803
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.AF.18729.3D0B9A76; Mon, 10 Feb 2025 16:54:59 +0900 (KST)
Received: from INBRO001561 (unknown [107.122.12.6]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250210075458epsmtip23ed4d1a3bb38732f3092bfad636fb382~iyaDFWaaM0703907039epsmtip2y;
	Mon, 10 Feb 2025 07:54:58 +0000 (GMT)
From: "Pankaj Dubey" <pankaj.dubey@samsung.com>
To: "'Aatif Mushtaq'" <aatif4.m@samsung.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <aswani.reddy@samsung.com>
In-Reply-To: <20250210061915.26218-4-aatif4.m@samsung.com>
Subject: RE: [PATCH 3/3] dmaengine: pl330: Add DMA_2D capability
Date: Mon, 10 Feb 2025 13:24:57 +0530
Message-ID: <05c801db7b91$15058800$3f109800$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgJaKAVsAmCg8Nqz+QrNYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTS/fyhpXpBu2ntS2OzfjIaHFo81Z2
	i9VT/7JaXN41h81i550TzA6sHptWdbJ59G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGzZOrGQuesFT8fbGQqYGxmaWL
	kZNDQsBE4u3dN2xdjFwcQgJ7GCXmbpjFDuF8YpR4MWcHlPONUeLAjivMMC1zF5xghEjsZZSY
	M2MClPOCUeLejyZWkCo2AX2Jcz/mgdkiAvUSTe0PwRYyC8hJNO1qYQSxOQWsJI6v2sEEYgsL
	OEg87GsHsjk4WARUJRY8ZQcxeQUsJW5NjQCp4BUQlDg58wnUFHmJ7W/nQN2jIPHz6TKoTU4S
	XQ/+sUPUiEu8PHoE7AEJgb/sEgcuL2CEaHCRWHjgA1SzsMSr41vYIWwpic/v9rKB7JUQ8JFY
	utsDIlwisaFnKTS47CUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTrahCCq1SS+Pz8DtUhG
	4mHzUiYI20OifcVi9gmMirOQPDYLyWOzkDwwC2HZAkaWVYxSqQXFuempyaYFhrp5qeXw6E7O
	z93ECE6PWgE7GFdv+Kt3iJGJg/EQowQHs5IIr8nCFelCvCmJlVWpRfnxRaU5qcWHGE2BgT2R
	WUo0OR+YoPNK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTC57Y0V
	7/nAqGdUYzbBd+Mmw4X6OkW1wt0Ji52/VuypmNhgqfD+4Camd/l5f+fMUE6acnmz+8Wnb5MZ
	Isx+/sx5sfjnUtuwm9d2ffw+NaYjQkVxCxeX7+mFIvyTDz1tY92ftWhOZP2n1pUXBJn3MdVf
	2bKk5gmjlu7BN6JOX67b2hRcNL+cF7069fedQ4d+br6mqK9Vs8/puueqk8c1TY6sFr34rVb8
	d7HmyURp1+bZ+YtbufwXhTDeU5izWG33ZAN2pmKFN9dK5u9zLzxeqWSYur2caWXA/lq5uuYP
	y54dvc/4c9nTjus2J+c4WkXv9M8I8NRdrxZ6/snhQ0E/l2bM3vQvPcrJ6ahYf7LOciE/JZbi
	jERDLeai4kQAAiqenBgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvO7lDSvTDXb8ELQ4NuMjo8WhzVvZ
	LVZP/ctqcXnXHDaLnXdOMDuwemxa1cnm0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBk3T65m
	LHjCUvH3xUKmBsZmli5GTg4JAROJuQtOMHYxcnEICexmlLj9cy9UQkZi8uoVrBC2sMTKf8/Z
	IYqeMUosPHCQHSTBJqAvce7HPFaQhIhAM6PEyZ1XwDqYBeQkmna1QI3dySjxYtE9RpAEp4CV
	xPFVO5hAbGEBB4mHfe1ANgcHi4CqxIKn7CAmr4ClxK2pESAVvAKCEidnPmGBGKkt0fuwlRHC
	lpfY/nYOM8RxChI/ny4DWysi4CTR9eAfO0SNuMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sq
	RsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgONHS3MG4fdUHvUOMTByMhxglOJiVRHhN
	Fq5IF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cDUfiN/
	qVFkb0/afb2MPeYLHf+pXfrxQL8uf7/VrfvS5+00YrJdPbfZt/lHWN/ddvvK2dueZuZStoyS
	bIEvM+suqsVrtZxl12fie/Dg7WntB/IvT03w4VhYKP9ZeO1MhU8W/8qFtN2b/kc7CCv/rDxb
	t8Gcw7y6686mHSFrNkY6PhMJUtx98n9zknee3w/uRRvsM4SsORp/uO1dNinkaouhZqSg4Ksj
	u6qLb0uqFWmUfpxt3n1jfdSv2fKtHZfWruqadvSM6kPHN29DdT2Pnzp1RTuS4SnvGS9FXq6c
	E+eUJ51v/ahuYJ1aym03Y9ILBaeLybve9U0wnDPzpuze/2wd3XdizZVPXPpsc9VP7r4SS3FG
	oqEWc1FxIgC47UQGAgMAAA==
X-CMS-MailID: 20250210075459epcas5p2eb0d4b6916f999e7c98d7e869e2d0ad6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062258epcas5p195b96f374fa9ce1802ec4d1c1e73f69c@epcas5p1.samsung.com>
	<20250210061915.26218-4-aatif4.m@samsung.com>



> -----Original Message-----
> From: Aatif Mushtaq <aatif4.m@samsung.com>
> Sent: Monday, February 10, 2025 11:49 AM
> To: vkoul@kernel.org; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: pankaj.dubey@samsung.com; aswani.reddy@samsung.com; Aatif Mushtaq
> <aatif4.m@samsung.com>
> Subject: [PATCH 3/3] dmaengine: pl330: Add DMA_2D capability
> 
> Add a capability to prepare DMA for 2D transfer and create a hook
> between the DMA engine and the pl330 driver
> 
> Signed-off-by: Aatif Mushtaq <aatif4.m@samsung.com>
> ---

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>


