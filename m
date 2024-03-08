Return-Path: <dmaengine+bounces-1307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C6876185
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 11:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0371F2324B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD854746;
	Fri,  8 Mar 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NxFcIXg7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0553E32
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892450; cv=none; b=GXHkqdY9zdIOVNiMtGpv2/miNhDZGAyEv8NRytbBc7mE596xc66j9pWVrHwgDhudi/Y8WVDFvN3m2wAjmJdhtiAQHj3+6/Sh48VHeLM/1lgc+AyCL9B5LIRv2tWHBXtGDRzFgUB39eiK4dEoZcoiSFtWabMzOq2TYo4B4RShX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892450; c=relaxed/simple;
	bh=NE5YGAo9a2aMpexhYeOPfopmtOkL/3NojeeJNudCn1w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ngRViLVZWQT5V0O8tKLZXXt4hI93IUva77jk4Do7JHHYEeNJ9pv1grohJBrtXQRujsYUBj/V6o5+hLb04GqovbdwAN2V1DemFfDCFQC8X9pXuSt5YhjORVBLQmHKKR6O565+3sNYOmo+c9MDFvlyqyAhsI8pq1UZI02FDVYSR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NxFcIXg7; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240308100724epoutp01d10b5e8008338905be263246d4ceab86~6wh54cb4J1907019070epoutp01J
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 10:07:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240308100724epoutp01d10b5e8008338905be263246d4ceab86~6wh54cb4J1907019070epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709892444;
	bh=Pq3v3eHbmP1sbT/9JO4DucB7TQ8gsxuDdAu3MV3sdic=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=NxFcIXg7a06nnDesj7DSfycocFfDIfinIKOtWEZf6WaVQ37SulZzVs09xpvkZqvRD
	 9VQJgUBtjCou60vaG6/qegpit8+ZQPh78z/hpjEqYky/SsPg3CsXwxCeHhnqRiWPxi
	 E6fTgKAeDksTSel504UTT9Xla84HyHofe67kpEw4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240308100723epcas2p255d3d088a2e77bd625652d01a7fe56b1~6wh5Pbwou0805708057epcas2p2h;
	Fri,  8 Mar 2024 10:07:23 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Trhfz4Zc3z4x9Pr; Fri,  8 Mar
	2024 10:07:23 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.2B.09607.B53EAE56; Fri,  8 Mar 2024 19:07:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240308100723epcas2p4c1965c0c4e63780322bf2db8a6d0b508~6wh4rPLvp0863708637epcas2p4w;
	Fri,  8 Mar 2024 10:07:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240308100723epsmtrp2f759477828557936677387475cd746e6~6wh4qmnY53140831408epsmtrp2Z;
	Fri,  8 Mar 2024 10:07:23 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-cd-65eae35be42c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.81.07368.B53EAE56; Fri,  8 Mar 2024 19:07:23 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.202]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240308100723epsmtip29090d995d1eb216ee6aabdc770d6308b~6wh4hAU1x0857208572epsmtip2J;
	Fri,  8 Mar 2024 10:07:23 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: "'Linux regressions mailing list'" <regressions@lists.linux.dev>,
	"'karthikeyan'" <karthikeyan@linumiz.com>, <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban@linumiz.com>, <saravanan@linumiz.com>
In-Reply-To: <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
Subject: RE: dmaengine: CPU stalls while loading bluetooth module
Date: Fri, 8 Mar 2024 19:07:23 +0900
Message-ID: <000001da7140$6a0f1570$3e2d4050$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMwipOl/cAOi38P2p1VCUOGtvzp0QMWgtoHAULg3K4CqzIErK5JRjYw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmmW7041epBlN2qVisnvqX1WLHak2L
	y7vmsFnsvv2H1WLj2w52i3d7FC123jnB7MDusWlVJ5vH9s+n2D1ebJ7J6PF5k1wAS1S2TUZq
	YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QfiWFssScUqBQ
	QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbbOZ+Y
	C2ZyViw/8pa5gfEiexcjJ4eEgIlE95yJjF2MXBxCAjsYJZbdf8MG4XxilGiZ/5MVwvnGKHHi
	3U82mJY33yZCJfYySiz/9psdwnnJKDH9RAcjSBWbgK7EzJcHWUASIgKtjBJ3NlwF28gsUCzx
	qOkQWBGngKPEpz37wMYKA9m9kyawgtgsAioSW55+BbN5BSwlbszfwwRhC0qcnPmEBWKOvMT2
	t3OYIU5SkPj5dBlYvYiAm8S33dtYIWpEJGZ3tjGDHCEh0Mkhsb/9DhNEg4vEw9froJqFJV4d
	3wINDimJz+/2Qv2ZLzFzzg0WCLtG4uu9f1Bxe4lFZ34C1XMALdCUWL9LH8SUEFCWOHIL6jQ+
	iY7Df9khwrwSHW1CEKaqRNPNeogZ0hLLzsxgncCoNAvJX7OQ/DULyf2zEFYtYGRZxSiWWlCc
	m55abFRgAo/s5PzcTYzgpKnlsYNx9tsPeocYmTgYDzFKcDArifCyWLxMFeJNSaysSi3Kjy8q
	zUktPsRoCgzpicxSosn5wLSdVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFM
	HxMHp1QD06YtObaV19TElV3WzzQ9dv+3k4aijmnG2j+hlTsbvrxalL81YKafst96V85p3me7
	WEPc131nXxAXlzH/gZI99w1XGa3Yr9c8Tkrc145X+uh5ZmpVz9WStKmy4gdvcL0Jz+Dr3r/H
	pDSyZ4HiTyamxrN8UvK7y2+sufwzO0+7L5i11S9wyZSFdvq72xYf++B4tWTrhMjgmAe3nk6x
	Ypq6IvB5qP3pnVxvzCwv3VgVtJLJfZW3Zk/2wkdNHR9bmm1mh52/lK8wdarI4aVb9r9KNcxm
	b+YQUHzVvtil1/+t4r4/Kb9PBqluqqv4Jp0Z53/H075A82xb5OtzVQePMLA/eGdR+GXz1VkT
	PuYpfhSxU2Ipzkg01GIuKk4EAJOgypcjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvG7041epBhPeCFqsnvqX1WLHak2L
	y7vmsFnsvv2H1WLj2w52i3d7FC123jnB7MDusWlVJ5vH9s+n2D1ebJ7J6PF5k1wASxSXTUpq
	TmZZapG+XQJXxts5n5gLZnJWLD/ylrmB8SJ7FyMnh4SAicSbbxNZuxi5OIQEdjNK/Gt8xwyR
	kJZ40fqNFcIWlrjfcgSq6DmjxKWv38ESbAK6EjNfHmQBSYgItDNKLHhznAUkwSxQLnHtwG0m
	EFtI4DOjRPOnGhCbU8BR4tOefWwgtjCQ3TtpAtggFgEViS1Pv4LZvAKWEjfm72GCsAUlTs58
	AjVTW+LpzadQtrzE9rdzoC5VkPj5dBlYr4iAm8S33dtYIWpEJGZ3tjFPYBSehWTULCSjZiEZ
	NQtJywJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMExpKWxg/He/H96hxiZOBgP
	MUpwMCuJ8LJYvEwV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJ
	g1OqgUmpIiVJJ/t88Rvn5kPxuwS1zn3PNmXWZV6p4lF5589MJftG4YyljbJal7xfsn2cbvbR
	/2NL8DTBKyFmry2q0m20et6s52CW+ZVvPfno13U599f+33OrhE9EYOPmKXsn5TIcUTU+uv7e
	tthImfZrsrdfHXn9Y9bfnkI2Vn2lrRKnaw/+yZA90GF7Q36d1DSdx6+SJAQmTovtvS9qnSS4
	7/Ss2X+PH+5NCjV66LrVVUSStTovaemFH59SBDNux249X/jDwfR75ev8lQEHG+M5OBiPFbIu
	7t1sWfnPaR1nVsq3b99Us3Ydsdt6ssD0TIV9wMNGu79fV68RazKrX/dqVoCWwvTGfxEcL1Sd
	ZsfOklJiKc5INNRiLipOBABHH9EqEAMAAA==
X-CMS-MailID: 20240308100723epcas2p4c1965c0c4e63780322bf2db8a6d0b508
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
	<1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
	<000001da6ecc$adb25420$0916fc60$@samsung.com>
	<12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>

Hello

> Hmmm. 6.8 final is due. Is that something we can live with? Or would it be
> a good idea to revert above commit for now and reapply it when something
> better emerged? I doubt that the answer is "yes, let's do that", but I
> have to ask.

I couldn't find better way now.
I think it's better to follow you mentioned

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://protect2.fireeye.com/v1/url?k=1721f6f7-48bacfe8-17207db8-
> 000babdfecba-6a9835eff37b0303&q=1&e=f39e15ee-403b-4efb-a56e-
> f6aba3905bc5&u=https%3A%2F%2Flinux-
> regtracking.leemhuis.info%2Fabout%2F%23tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: To be sure the issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot report /
> #regzbot introduced 22a9d9585812440211b
> #regzbot duplicate: https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/
> #regzbot title dmaengine: CPU stalls while loading bluetooth module
> #regzbot ignore-activity


