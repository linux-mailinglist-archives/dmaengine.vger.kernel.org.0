Return-Path: <dmaengine+bounces-58-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2C7E62DA
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 05:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BD52811DF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99ADA57;
	Thu,  9 Nov 2023 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c+YfCZpJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA627A44
	for <dmaengine@vger.kernel.org>; Thu,  9 Nov 2023 04:34:50 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE7269E
	for <dmaengine@vger.kernel.org>; Wed,  8 Nov 2023 20:34:49 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231109043447epoutp0233f63737226f34a932a8226172de4780~V2lPFdzr80870308703epoutp02G
	for <dmaengine@vger.kernel.org>; Thu,  9 Nov 2023 04:34:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231109043447epoutp0233f63737226f34a932a8226172de4780~V2lPFdzr80870308703epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699504487;
	bh=3Wa6uhc41YZKRbzxe2Aw8h5ixBObfADsVT7rfpcVaDQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=c+YfCZpJ2PmaZ3zbeh5t8xPpDEkulm8vT1ltX72xKpwGimIwyZx9iSww3brRU9cGt
	 6jcW53FHupYJP6UAzH9jZxTY0g1WG62gU20kqTDz9gXfwu22C2fY6iAgHF1qpMXIpP
	 qTIMphYELf1ILBJ1fuDvfAvb1+I+Lps+qMaXxk5g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231109043447epcas2p1101b99e97db18ef0055cec5e3eaf4b58~V2lOzTGXs2156321563epcas2p1R;
	Thu,  9 Nov 2023 04:34:47 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SQpyZ648Xz4x9Pp; Thu,  9 Nov
	2023 04:34:46 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.D7.10006.6616C456; Thu,  9 Nov 2023 13:34:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20231109043446epcas2p275e26065eb1ede0f51565375a1579299~V2lN9bcGd0694606946epcas2p2O;
	Thu,  9 Nov 2023 04:34:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231109043446epsmtrp243c64cf1e268ad38e5a96e68618f6847~V2lN83V-52030320303epsmtrp2t;
	Thu,  9 Nov 2023 04:34:46 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-fa-654c6166c3fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.07.07368.6616C456; Thu,  9 Nov 2023 13:34:46 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.180]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231109043446epsmtip2f9fcdc0c53c0023536a3649807160ced~V2lNzFhIb2442424424epsmtip2C;
	Thu,  9 Nov 2023 04:34:46 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Vinod Koul'"
	<vkoul@kernel.org>, "'Philipp Zabel'" <p.zabel@pengutronix.de>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0db70a26-bc3f-48f4-acfc-9fc7f960252f@kernel.org>
Subject: RE: [PATCH] dmaengine: pl330: set subsys_initcall level
Date: Thu, 9 Nov 2023 13:34:46 +0900
Message-ID: <002301da12c6$11465ee0$33d31ca0$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJw0jBUXmzjAmMVPDflHh3pWMsQ7QN1UX++AeZEPFavGQrX8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTXDct0SfVYPZkQ4vVU/+yWpw/v4Hd
	4vKuOWwWd++dYLHYeecEswOrx6ZVnWwe/X8NPD5vkgtgjsq2yUhNTEktUkjNS85PycxLt1Xy
	Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzlj04TpLwTeOig9TtrA2ME5n72Lk
	5JAQMJG4fHQ1kM3FISSwg1Hi9uJuFgjnE6PE02cTmCGcb4wSqyb2wLVcWzWVESKxl1Gifelb
	NgjnJVD/tetMIFVsAroSM18eZAGxRQTqJFbunckMYjML2Et0XW8Fq+EUsJO4sW0BI4gtLOAg
	cXTLfzYQm0VARaLxxQ2gXg4OXgFLic5p2iBhXgFBiZMzn7BAjNGWWLbwNTPEQQoSP58uY4VY
	5SSx8UsDI0SNiMTszjawDyQEfrJLrL20jg2iwUWi/8xRFghbWOLV8S1Qn0lJfH63F6omW+LI
	of9Q8QqJYyf6mCBsY4lZz9oZQW5jFtCUWL9LH8SUEFCWOHIL6jQ+iY7Df9khwrwSHW1CEKaq
	RNPNeogZ0hLLzsxgncCoNAvJX7OQ/DULyf2zEFYtYGRZxSiWWlCcm55abFRgCI/q5PzcTYzg
	pKjluoNx8tsPeocYmTgYDzFKcDArifBeMPFJFeJNSaysSi3Kjy8qzUktPsRoCgzoicxSosn5
	wLScVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QD09Jnr/9taJfO
	bZCPFOvvEr4U+0pwwdHnvr7fArv7l632mbdXSfKn54vga6VOkave+dfGqWYtbzFk/nsz9rxr
	4pvvT/QU88tENLIfJ+9KeDCV068vSn4hjxJzebtKwRHthUpdSftLTLft/lAkbZL97sqBvIyv
	bhZfX2+w3DW5OkNL7saZpKmrZOYcYZxnrLs5N/XVxwT1ny0rL4UkphdufFoaGlbvMPf0B8YZ
	XUUJCU61h4321wR1p/nmf/mWtkViqcw1iUPfJX1Klj9x5hFgNKzKuGZ5ds+9pIsLxRbobvnn
	OnVqetuCxx1z8zdeuWpvKcRTXv90Ct/+FWxqcteLs/8cXC3UbMkYFTr91oVGJZbijERDLeai
	4kQAQKLOMBMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvG5aok+qwYJuGYvVU/+yWpw/v4Hd
	4vKuOWwWd++dYLHYeecEswOrx6ZVnWwe/X8NPD5vkgtgjuKySUnNySxLLdK3S+DKuLZvAmPB
	f46K1oOTGRsYZ7F3MXJySAiYSFxbNZWxi5GLQ0hgN6PEsacfWCES0hIvWr9B2cIS91uOsEIU
	PWeUmP3gEzNIgk1AV2Lmy4MsIAkRgQZGiZcL+oBGcXAwCzhK7JztDtFwkFHi+upJTCANnAJ2
	Eje2LWAEsYUFHCSObvnPBmKzCKhINL64wQLSyytgKdE5TRskzCsgKHFy5hMWEJtZQFvi6c2n
	cPayha+ZIY5TkPj5dBnYoSICThIbvzQwQtSISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsY
	JVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYKjREtjB+O9+f/0DjEycTAeYpTgYFYS4b1g
	4pMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA5OntKDB
	YQ7DSbUtEuzLldIq+vreNhpkHGlcz9K8p0+mM0Q5tPe1aee51/4v706Pmd7RzrDb/6/09Pw1
	O4IFWb4wHH93jPHudT6Vs9+u/hH7xvvj1d70wMPtz6NcLvF16HGIz9r6MI9F3k9HJH7KoYTo
	jNqDGoaPqputC84+KnjrlmAQtGfBw9Sbrl8Zz33yDu3Nvs2o0J0+8+X3w+7MuQLnzH4ZxYZ2
	HW44t4mvRiCt+Zcq97On9i39drxZXU+CLj/fzCOz4uLC6VcuxKSmivmniSszCe7+uTHLZzf3
	9RWm+peveU1NnFX/TPhlR8mxgC8rXbaXH9NYliNxdK7/uTgZgavbaz2TQwVe5UryKbEUZyQa
	ajEXFScCANn2A+QBAwAA
X-CMS-MailID: 20231109043446epcas2p275e26065eb1ede0f51565375a1579299
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9
References: <CGME20231031035024epcas2p240760f064c90e017a3ada73d9271e9c9@epcas2p2.samsung.com>
	<20231031034854.115624-1-bumyong.lee@samsung.com>
	<0db70a26-bc3f-48f4-acfc-9fc7f960252f@kernel.org>

> On 31/10/2023 04:48, Bumyong Lee wrote:
> > module_amba_driver is macro for module_init/exit module_init is
> > device_initcall level when it configured with built-in driver.
> >
> > pl330 is dmaengine driver. because slave drivers depend on dmaengine
> > drivers, dmaengine drivers is more appropriate subsys_initcall.
>=20
> The same is true for all resource providers and we do not manually order
> them via initcalls. Sorry, this was fine as is. Implement defer for your
> drivers, not hack initcalls. If you upstreamed them, then it could even
> work out of the box for you .
>=20
> Best regards,
> Krzysztof

I agree with your opinion that the drivers using dma-engine should implemen=
t to defer probe when dma is not initialized yet in their probe function ex=
ecution.
But if dma-engine driver and slave driver is the same initcall level, then =
a lot of slave drivers should defer probe every time of boot.

I think it's better to use subsys_initcall for pl330 like other dmaengine d=
rivers regardless of slave driver's implementation in order to reduce defer=
 operations.

Best regards
Bumyong Lee


