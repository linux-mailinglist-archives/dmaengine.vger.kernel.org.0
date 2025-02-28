Return-Path: <dmaengine+bounces-4596-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B693BA495D6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CCD3AE614
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3D25BAA3;
	Fri, 28 Feb 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S/RWWl19"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64E25A2B7
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736106; cv=none; b=aTz8jOsvDrZhn2EjYZR4wcQ7AwKLH1Iq0LFUdoTSRyNXEeVqrjSoKFjmc4NocEBl55wO/qYfZCMD0WY9L1ty89gjcmveXDva8x3oYrWoYCq77ae1V+uQ3c0aM5URVxuBEXNfNFAOA96OWphXMj24E+zQtctzS+04eQ5hZrDHjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736106; c=relaxed/simple;
	bh=+VGlrcMkX1K2VS8U8w5wXHYGRlKs8sR/ErFu8U6uiM4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=S5ieIvMS/8XOqqSkgTKCaMZldh24bg8HC8LjWv9L9Py19v8pVjIeFVFfFKh0VuY6ls1YcnUFlElHh32pH+zMb6XlO2XVV8+Ezb8RJTwAySfUTODyuijxcvrKUlOEgz3XsgXuLnjDb5mQfPZwPy3XYj71A2rBVwvfFVpC907JGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S/RWWl19; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250228094816epoutp04e936acb20e6d34e2da09fa5bde997d58~oVkHDcRDT2730427304epoutp04L
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 09:48:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250228094816epoutp04e936acb20e6d34e2da09fa5bde997d58~oVkHDcRDT2730427304epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740736096;
	bh=+VGlrcMkX1K2VS8U8w5wXHYGRlKs8sR/ErFu8U6uiM4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=S/RWWl19KUxN0YpO8kGGwYiy2/MrDQt3ofBqVOvSAGghho66vf5vYSEeg7jaulc8G
	 Bpuhv9NTxQt2bYZrcDX/3IvIpaXx3R8YLe1Dke68qbb4OZucyqix1WoQY1TjlygbzI
	 xkw+Gcb+Nei6csulHCw8Qul+LHgxWOC3OwgT+euU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250228094815epcas5p211189858b5cf42668d467ec56e4c06c5~oVkGmnbau1019710197epcas5p2o;
	Fri, 28 Feb 2025 09:48:15 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z43L65pMsz4x9Ps; Fri, 28 Feb
	2025 09:48:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.C6.19710.E5681C76; Fri, 28 Feb 2025 18:48:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250228092913epcas5p448e2b09ec4b6d10393c16abd9c55b52a~oVTe0il-K0248302483epcas5p4r;
	Fri, 28 Feb 2025 09:29:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250228092913epsmtrp1de4e56ca0c49cf79f6d551aa26cd624c~oVTez89-q1877618776epsmtrp1g;
	Fri, 28 Feb 2025 09:29:13 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-69-67c1865e1f91
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.C8.18729.9E181C76; Fri, 28 Feb 2025 18:29:13 +0900 (KST)
Received: from FDSFTE245 (unknown [107.122.81.20]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250228092912epsmtip29f790d19a279e604aea4f1c30d36c358~oVTd32oCH3062430624epsmtip2b;
	Fri, 28 Feb 2025 09:29:12 +0000 (GMT)
From: "Aatif Mushtaq/Aatif Mushtaq" <aatif4.m@samsung.com>
To: "'Vinod Koul'" <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "'PANKAJ
 KUMAR	DUBEY'" <pankaj.dubey@samsung.com>, "'ASWANI REDDY'"
	<aswani.reddy@samsung.com>
In-Reply-To: <Z8AbqGa9lZYnWddp@vaman>
Subject: RE: FW: [PATCH 0/3] Add capability for 2D DMA transfer
Date: Fri, 28 Feb 2025 14:58:57 +0530
Message-ID: <000401db89c3$3ab1cb00$b0156100$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsIHTrWqAe9Pu9L3iNOvGTrR8WTgJZ87QCAa5Z684CL8kbw7QJhB+A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTUzeu7WC6waHvuhaHNm9lt1g99S+r
	xeVdc9gsFm39wm6x884JZgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjxowDbAW99RVX7hY3MC6q6GLk
	5JAQMJG4d2kOSxcjF4eQwG5GiVcnv7JCOJ8YJS4v2MoE4XxjlPh/bSUrTMu0llZ2iMReRokN
	95cxQzjPGSXW/drHBlLFJmAlcR7KFhFQldjy5AEbSBGzwGJGiSMv/zKDJDiBEsv7loEVCQvY
	S3w6uhUszgIU7/vczwhi8wpYSsw7N4kZwhaUODnzCQuIzSygLbFs4WtmiJMUJH4+XQZ0HgfQ
	MjeJmy+lIUrEJY7+7AE7TkLgJ7vEzYkPWCDqXSQWXf/PBmELS7w6voUdwpaSeNnfBmUnS9x8
	vw/KzpGYsHA1lG0vceAKKMQ4gBZoSqzfpQ8RlpWYemodE8RePone30+YIOK8EjvmwdhKEmve
	90GtlZD4d/Ak4wRGpVlIPpuF5LNZSF6YhbBtASPLKkbJ1ILi3PTUZNMCw7zUcniEJ+fnbmIE
	p0gtlx2MN+b/0zvEyMTBeIhRgoNZSYR3VuyBdCHelMTKqtSi/Pii0pzU4kOMpsDgnsgsJZqc
	D0zSeSXxhiaWBiZmZmYmlsZmhkrivM07W9KFBNITS1KzU1MLUotg+pg4OKUamOZlNXM/anf+
	2x36uviXGJNczbF5772yz/Tsf/tSPZhFOn/CCX05L8NSZX/hV3OlKoJyflWfiZi0qfxFCYOq
	9qGl6VtDzRNKq31W30k37jIT8rTQLYyzndfGeizw/5HuY+fY6pa+lfuToScmeuERF0dTzDeD
	Q5Of93677dK3/J3V9ctr5Jp4LrX/3uB2OIRbRN0479lt1c1d9wJiHESnn3vDdNYtLOXmljX6
	FgH7ZGsknhw//O1sfk1W2bFHM45+8d6e5hAt+fNmTmSp3rqDhVe/r13xcOOnvv+iM9aeuzhH
	ol8mnOf2h1zJN7ObLTYv9nc0ML2jvWDZ9p4HHnXsZmwPA60Lm7PbmWaseWV/VomlOCPRUIu5
	qDgRAA1FzskaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO7LxoPpBituq1sc2ryV3WL11L+s
	Fpd3zWGzWLT1C7vFzjsnmB1YPTat6mTz6NuyitHj8ya5AOYoLpuU1JzMstQifbsErozj+3ex
	FOzJqdj9YRVLA+OlhC5GTg4JAROJaS2t7F2MXBxCArsZJXpuvmGHSEhINHc2MkHYwhIr/z2H
	KnrKKPH62g9mkASbgJXE+V/72EBsEQFViS1PHrCBFDELLGWUWHlhLyNExy1Gia9H/rGAVHEC
	VS3vWwbWISxgL/Hp6FawSSxA8b7P/YwgNq+ApcS8c5OYIWxBiZMzn4D1MgtoS/Q+bGWEsZct
	fM0McZ6CxM+ny1i7GDmArnCTuPlSGqJEXOLozx7mCYzCs5BMmoVk0iwkk2YhaVnAyLKKUTK1
	oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4UrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5ZsQfS
	hXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAFbJyw5Mdb
	H1X1TTt9tXsOBMWVRmy7ZBj103HLRKlTUeLpX8+6PZlzg/FIcXRcU4zw/uwrP+yv/jqTqjV1
	c/8xo6sr5+1Obsi7vkP/8vXP6ReOz2gNFl/qvlzQy2elZi6X86YmKSM53Un1N4sjsnmOu+9j
	ff9udoBRJvOtYwf+PbhkJZ4sO23LfSm5L5MiLWtttnKYr1/zQUMmdV3ZhFWJ7VXFUTU7/gnd
	bxDRcJSeEXPjQFXBPRWmTWeCuOPWH0u5d3zFouI7gUzTIm7PnPv3vsNBvm0fjhk8ytNnnXht
	5SNz6W2VBlmzHj6onv9J/W5AsdvvTft3PY145mpxVUZc+fNSI6tXh04mfFm54JR9kxJLcUai
	oRZzUXEiABbKFhoDAwAA
X-CMS-MailID: 20250228092913epcas5p448e2b09ec4b6d10393c16abd9c55b52a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12
References: <20250210061915.26218-1-aatif4.m@samsung.com>
	<CGME20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12@epcms5p5>
	<20250224084948epcms5p57acb02e41b7626321d82c74569361be5@epcms5p5>
	<Z8AbqGa9lZYnWddp@vaman>



> -----Original Message-----
> From: Vinod Koul <vkoul=40kernel.org>
> Sent: 27 February 2025 13:31
> To: Aatif Mushtaq <aatif4.m=40samsung.com>
> Cc: dmaengine=40vger.kernel.org; linux-kernel=40vger.kernel.org; PANKAJ
> KUMAR DUBEY <pankaj.dubey=40samsung.com>; ASWANI REDDY
> <aswani.reddy=40samsung.com>
> Subject: Re: FW: =5BPATCH 0/3=5D Add capability for 2D DMA transfer
>=20
> On 24-02-25, 14:19, Aatif Mushtaq wrote:
> > <=21DOCTYPE html>
> > <html>
> > <head>
> > <meta http-equiv=3D=22Content-Type=22 content=3D=22text/html; charset=
=3DUTF-8=22
> > class=3D=22cui-content-default=22> <style class=3D=22cui-content-defaul=
t=22
> > data-cafe-default=3D=22true=22>=40charset =22UTF-8=22;/*=21 cafe note v=
2.3.34.7 =7C
> > Copyright 2014, S-Core, Inc. All Right Reserved.
> > */body,html=7Boverflow:visible=21important;height:auto=7Dhtml=7Bheight:=
auto=7Dbo
> > dy=7Bdisplay:block;margin-left:24px;margin-right:20px;margin-top:16px=
=7Dbo
> > dy ol,body ul=7Bmargin:0;padding-left:40px=7Dbody li,body
> > p=7Bline-height:1.9;margin:0 auto=7Dbody
> > .cui-quote=7Bmargin-left:4px;margin-bottom:20px;padding-left:6px;border=
-
> > left:4px solid =23ccc=7Dbody .cui-quote h1,body .cui-quote h2,body
> > .cui-quote h3,body .cui-quote h4,body .cui-quote h5,body .cui-quote
> > h6,body .cui-quote li,body .cui-quote
> > p=7Bmargin-bottom:4px=7Dtable.cui-div=7Bdisplay:block=7Dtable.cui-div>t=
body=7Bdi
> > splay:block=7Dtable.cui-div>tbody>tr=7Bdisplay:block=7Dtable.cui-div>tb=
ody>t
> > r>td,table.cui-div>tbody>tr>th=7Bdisplay:block=7Dfigure.cui-og,figure.c=
ui-
> > temp-og=7Bmargin:0;display:block;margin-inline-start:0;margin-inline-en=
d
> > :0=7D.cui-og-container=7Bdisplay:inline-flex=7D.cui-og-container
> > .cui-og-button-close=7Bdisplay:none;width:20px;height:20px;cursor:point=
e
> > r;border:none;border-radius:4px;background-color:=23fff;background-posi=
t
> > ion:center;background-
> image:url(=22data:image/png;base64,iVBORw0KGgoAAAA
> >
> NSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAI5JREFU
> OE+9lLEVgDAIR
> >
> C8b6Tw0Opk2zKMj+XjPApUABTFtLj9wXNJQvFoxD+OBzDwR0Zmp3NI+KhQB
> gAPASkS7B2X
> >
> mBcAGYNYFfFpWwi7U05geegeiC7tDsQ5GMLHInbIG3H6KZ66/YWwUVJjhsP4
> FlrZcOpTS2
> >
> GSikQ72qKdX9zlkfphIE+YwArz3y4EXDCF2FapWr4IAAAAASUVORK5CYII=3D=22);po
> sition
> > :relative;top:10px;left:-30px;z-index:1=7D.cui-og-container
> > .cui-og-button-close.cui-state-focus=7Bdisplay:block=7Dtable.cui-pasted=
-ta
> > ble h1,table.cui-pasted-table h2,table.cui-pasted-table
> > h3,table.cui-pasted-table h4,table.cui-pasted-table
> > h5,table.cui-pasted-table h6,table.cui-pasted-table
> > li,table.cui-pasted-table p,table.cui-pasted-table
> > td,table.cui-pasted-table
> > th=7Bline-height:normal=7Ddiv=5Bdata-cui-alt-image=5D,img=5Bdata-cui-al=
t-image=5D=7B
> >
> background:url(=22data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB
> YAAAAU
> >
> CAYAAACJfM0wAAABH0lEQVQ4jbXU26qEIBQGYF+wtxLMgg4QdGdBREUhFE
> FBBx/tn6sGpc
> >
> PezTTCAi/0Q11rSQghhDGGJ4P8An3j20QIgSzLvookSfawUgrrukIp9VVcwkIIcM
> 7h+z66
> >
> rnsGbprGeCvf95+B8zw3YM75M/A4jnAcB3pS9Y3zPKPv+0vYKDf9jcdxRJ7naJr
> G2DRNE8
> >
> IwBGMMZVkewmQbOnwVy7IgiqL3TWzbRtu2x+gVnKYpXNdF27ZY1xVxHO+a
> wHVdDMMAKaWJ
> >
> nsFZlhkn8zzvtMOCIACl1No8Sqm1S55SCkVR3GrdI3QH13V9/7PRxmG5SSlh2/b
> HKGMMVV
> >
> XtYc75bZRSaunX1w92+9vUT6mju3WfJuqvv/zf8FmZXq7/BfoCA1VRsvK4AfgA
> AAAASUVO
> > RK5CYII=3D=22) no-repeat center
> > =23c1c1c1=7Dbody::-webkit-scrollbar=7Bopacity:.08;width:6px;height:6px=
=7Dbody:
> > :-webkit-scrollbar-thumb=7Bbackground-color:rgba(0,0,0,.15);border-radi=
u
> > s:7px;width:6px=7D.cui-knoxtaskinput-line=7Bheight:150px=7D.cui-knoxtas=
kinpu
> > t-line.double-line=7Bheight:170px=7D.cui-customtask-card=7Bwidth:560px;=
heigh
> > t:68px;border-radius:8px;border:solid 1px
> > =23dbdbdb;background-color:=23fff;border-spacing:0px;table-layout:fixed=
;ma
> > rgin-bottom:20px=7D.cui-customtask-card
> > td=7Bmargin:0;padding:0;border:0=7D.cui-customtask-card
> > td>p=7Bwidth:422px;margin-left:0;text-overflow:ellipsis;white-space:now=
r
> > ap;overflow:hidden=7D.cui-customtask-card
> > .cui-customtask-card-cell=7Btext-overflow:ellipsis;white-space:nowrap;o=
v
> > erflow:hidden=7D.cui-customtask-card
> > .cui-customtask-card-image=7Bwidth:40px;height:40px;margin:0 15px 0
> > 15px;border-radius:22px;background-color:=23e96b6b;vertical-align:middl=
e
> > =7D.cui-customtask-card
> > .cui-customtask-card-content-task=7Bfont-size:15px;font-weight:700;font=
-
> > stretch:normal;font-style:normal;letter-spacing:normal;text-align:left
> > ;color:=23000;line-height:20px;height:100%=7D.cui-customtask-card
> > .cui-customtask-card-content-asignee=7Bfont-size:12px;font-weight:400;f=
o
> > nt-stretch:normal;font-style:normal;letter-spacing:normal;line-height:
> > 20px;text-align:left;color:rgba(0,0,0,.9)=7D.cui-taskcard-wrapper=7Bdis=
pla
> > y:block;height:72px;margin-bottom:20px=7D.cui-taskcard-wrapper
> > .cui-taskcard-more=7Bwidth:32px;height:32px;padding:0;border:0;backgrou=
n
> > d-image:url(=22./cafe/knox/2.3.34.7/skins/default-knox/images/ic_more_h=
o
> > rizontal_normal.png=22);background-size:16px
> > 16px;background-repeat:no-repeat;background-
> position:center;background
> > -color:transparent;border-radius:16px=7D.cui-taskcard-wrapper
> > .cui-taskcard-more-hover=7Bbackground-image:url(=22./cafe/knox/2.3.34.7=
/sk
> > ins/default-knox/images/ic_more_horizontal_active.png=22);background-co=
l
> > or:rgba(0,0,0,.06)=7D.cui-taskcard-wrapper-menu=7Bwidth:122px;height:80=
px;
> > border-radius:8px;box-shadow:0 3px 4px 0 rgba(0,0,0,.08);border:solid
> > 1px
> > =23dbdbdb;background-color:=23fff;position:absolute;top:46px;left:516px=
=7D.c
> > ui-taskcard-wrapper-menu
> > .cui-taskcard-wrapper-menu-ul=7Bmargin:8px;padding:0;list-style:none=7D=
.cu
> > i-taskcard-wrapper-menu
> > .cui-taskcard-wrapper-menu-item=7Bposition:relative;width:106px;height:=
3
> > 2px;border-radius:4px;list-style-image:url(=22data:image/gif;base64,R0l=
G
> >
> ODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7=22);mar
> gin:0
> > auto=7D.cui-taskcard-wrapper-menu
> > .cui-taskcard-wrapper-menu-item-hover=7Bborder-radius:4px;background-
> col
> > or:rgba(0,0,0,.06)=7D.cui-taskcard-wrapper-menu
> > .cui-taskcard-wrapper-menu-icon=7Bwidth:20px;height:20px;margin:0 0 6px
> > 0;position:absolute;top:4px;left:8px=7D.cui-taskcard-wrapper-menu
> > .cui-taskcard-delete=7Bbackground-image:url(=22./cafe/knox/2.3.34.7/ski=
ns/
> > default-knox/images/ic_memo_delete.png=22)=7D.cui-taskcard-wrapper-menu
> > .cui-taskcard-update=7Bbackground-image:url(=22./cafe/knox/2.3.34.7/ski=
ns/
> > default-knox/images/ic_edit.png=22);background-repeat:no-
> repeat;backgrou
> > nd-position:center=7D.cui-taskcard-wrapper-menu
> > .cui-taskcard-wrapper-menu-text=7Bwidth:52px;height:19px;font-family:=
=22Ma
> > lgun Gothic=22,=22=EB=A7=91=EC=9D=80=20=EA=B3=A0=EB=94=95=22,Dotum,=22=
=EB=8F=8B=EC=9B=80=22,Gulim,=22=EA=B5=B4=EB=A6=BC=22,=22Apple=20SD=20Gothic=
=0D=0A>=20>=20Neo=22,=22Segoe=20UI=20WPC=22,=22Segoe=0D=0A>=20>=20UI=22,Hel=
vetica,sans-serif;font-size:13px;font-weight:400;font-stretch:n=0D=0A>=20>=
=20ormal;font-style:normal;line-height:2.15;letter-spacing:normal;text-al=
=0D=0A>=20>=20ign:left;color:rgba(0,0,0,.9);position:absolute;left:34px=7D.=
cui-mention=0D=0A>=20>=20.cui-mention-edited=7Bdisplay:inline-block;padding=
:1px=0D=0A>=20>=204px;border-radius:4px;background-color:rgba(187,187,187,.=
19)=21important=0D=0A>=20>=20;color:=232a82f0=21important;font-weight:400=
=21important;font-style:normal=21i=0D=0A>=20>=20mportant;font-family:=22=EB=
=A7=91=EC=9D=80=0D=0A>=20>=20=EA=B3=A0=EB=94=95=22=21important;text-decorat=
ion:none=21important;line-height:normal=7D.cui-=0D=0A>=20m=0D=0A>=20>=20ent=
ion.cui-mention-editing=7Bpadding:1px=0D=0A>=20>=204px;border-radius:4px;ba=
ckground-color:rgba(0,0,0,.06);color:rgba(0,0,=0D=0A>=20>=200,.9)=7D</style=
>=20<style=20class=3D=22cui-content-default=22=0D=0A>=20>=20data-user-confi=
g=3D=22true=22>=0D=0A>=20=0D=0A>=20???=0D=0A>=20=0D=0A>=20Pls=20stop=20send=
ing=20HTML=20emails=20to=20the=20lists=21=0D=0A=0D=0AThis=20was=20a=20mista=
ke,=20I=20will=20take=20care=20from=20next=20time.=0D=0A=0D=0A>=20=0D=0A>=
=20>=20body=20=7Bmargin:=2010px;=20font-size:=2010pt;=20font-family:Arial,s=
ans-serif;=0D=0A>=20>=20line-height:1.9;=7D=20p=20=7Bline-height:1.9;=7D=20=
body,body=20p,body=20li,body=0D=0A>=20>=20h1,body=20h2,=20body=20h3,body=20=
h4,body=20h5,body=20h6=0D=0A>=20>=20=7Bfont-family:Arial,sans-serif;=20line=
-height:1.9;=7D=20</style></head>=0D=0A>=20>=20<body><p><span=20style=3D=22=
font-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=20>=2013.3333px;=22=
>Hi=20all=20=21<br><br></span></p>=20<p><span=20style=3D=22font-family:=0D=
=0A>=20>=20Arial,=20sans-serif;=20font-size:=2013.3333px;=22>I=20hope=20thi=
s=20email=20finds=20you=0D=0A>=20>=20well.=20I=20wanted=20to=20gently=20rem=
ind=20you=20to=20please=20take=20out=0D=0A>=20>=20some&nbsp;</span></p>=20<=
p><span=20style=3D=22font-family:=20Arial,=20sans-serif;=0D=0A>=20>=20font-=
size:=2013.3333px;=22>valuable=20time=20from=20your=20schedule=20to=20revie=
w=20the=0D=0A>=20>=20patch=20chain.</span></p>=20<p><span=20style=3D=22font=
-family:=20Arial,=0D=0A>=20>=20sans-serif;=20font-size:=2013.3333px;=22><br=
></span></p>=20<p><span=0D=0A>=20>=20style=3D=22font-family:=20Arial,=20san=
s-serif;=20font-size:=0D=0A>=2013.3333px;=22>regards</span></p>=20<p><span=
=20style=3D=22font-family:=20Arial,=20sans-=0D=0A>=20serif;=20font-size:=20=
13.3333px;=22>Aatif=20Mushtaq</span></p>=20<p><span=0D=0A>=20style=3D=22fon=
t-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=2013.3333px;=22>&nbsp;=
</span></p>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-=0D=0A>=20=
serif;=20font-size:=2013.3333px;=22>---------=20<b><span=20style=3D=22font-=
family:=20Arial,=20sans-=0D=0A>=20serif;=20font-size:=2013.3333px;=22>Origi=
nal=20Message</span></b>=20---------=0D=0A>=20</span></p>=20<p><span=20styl=
e=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=2013.3333px;=
=22><b><span=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=
=0D=0A>=2013.3333px;=22>Sender</span></b>=20:=20Aatif=20Mushtaq=0D=0A>=20&l=
t;aatif4.m=40samsung.com&gt;FDS=20SW=20/SSIR/Samsung=0D=0A>=20Electronics</=
span></p>=0D=0A>=20>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-s=
erif;=20font-size:=0D=0A>=2013.3333px;=22><b><span=20style=3D=22font-family=
:=20Arial,=20sans-serif;=20font-size:=0D=0A>=2013.3333px;=22>Date</span></b=
>=20=20=20:=202025-02-10=2011:52=20(GMT+5:30)</span></p>=0D=0A>=20>=20<p><s=
pan=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=20=
>=2013.3333px;=22><b><span=20style=3D=22font-family:=20Arial,=20sans-serif;=
=20font-size:=0D=0A>=20>=2013.3333px;=22>Title</span></b>=20=20:=20=5BPATCH=
=200/3=5D=20Add=20capability=20for=202D=20DMA=0D=0A>=20>=20transfer</span><=
/p>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-serif;=0D=0A>=20>=
=20font-size:=2013.3333px;=22><b><span=20style=3D=22font-family:=20Arial,=
=20sans-serif;=0D=0A>=20>=20font-size:=2013.3333px;=22>To=20:=20</span></b>=
vkoul=40kernel.org,=0D=0A>=20>=20dmaengine=40vger.kernel.org,=20linux-kerne=
l=40vger.kernel.org</span></p>=0D=0A>=20>=20<p><span=20style=3D=22font-fami=
ly:=20Arial,=20sans-serif;=20font-size:=0D=0A>=20>=2013.3333px;=22><b><span=
=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=20>=
=2013.3333px;=22>CC=20:=20</span></b>PANKAJ=20KUMAR=0D=0A>=20>=20DUBEY&lt;p=
ankaj.dubey=40samsung.com&gt;,=20ASWANI=0D=0A>=20>=20REDDY&lt;aswani.reddy=
=40samsung.com&gt;,=20Aatif=0D=0A>=20>=20Mushtaq&lt;aatif4.m=40samsung.com&=
gt;</span></p>=0D=0A>=20>=20<p><span=20style=3D=22font-family:=20Arial,=20s=
ans-serif;=20font-size:=0D=0A>=20>=2013.3333px;=22>&nbsp;</span></p>=20<p><=
span=20style=3D=22font-family:=20Arial,=0D=0A>=20>=20sans-serif;=20font-siz=
e:=2013.3333px;=22>Add=20support=20for=20add=20halfword=0D=0A>=20>=20instru=
ction=20to=20pl330=20driver=20to=20achieve</span></p>=20<p><span=0D=0A>=20>=
=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=2013.3333px;=
=22>2D=20DMA=0D=0A>=20>=20operations.=20Add=20a=20corresponding=20dmaengine=
=20API=20to=20prepare=0D=0A>=20>=20the</span></p>=20<p><span=20style=3D=22f=
ont-family:=20Arial,=20sans-serif;=0D=0A>=20>=20font-size:=2013.3333px;=22>=
DMA=20for=202D=20transfer=20and=20create=20a=20hook=20between=0D=0A>=20>=20=
the=20dma=20engine=20and=20pl330</span></p>=20<p><span=20style=3D=22font-fa=
mily:=0D=0A>=20>=20Arial,=20sans-serif;=20font-size:=2013.3333px;=22>driver=
=20function.</span></p>=0D=0A>=20>=20<p><span=20style=3D=22font-family:=20A=
rial,=20sans-serif;=20font-size:=0D=0A>=20>=2013.3333px;=22><br></span></p>=
=20<p><span=20style=3D=22font-family:=20Arial,=0D=0A>=20>=20sans-serif;=20f=
ont-size:=2013.3333px;=22>Aatif=20Mushtaq=20(3):</span></p>=0D=0A>=20>=20<p=
><span=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-size:=0D=0A>=
=20>=2013.3333px;=22>&nbsp;=20dmaengine:=20Add=20support=20for=202D=20DMA=
=0D=0A>=20>=20operation</span></p>=20<p><span=20style=3D=22font-family:=20A=
rial,=20sans-serif;=0D=0A>=20>=20font-size:=2013.3333px;=22>&nbsp;=20dmaeng=
ine:=20pl330:=20Add=20DMAADDH=0D=0A>=20>=20instruction</span></p>=20<p><spa=
n=20style=3D=22font-family:=20Arial,=20sans-serif;=0D=0A>=20>=20font-size:=
=2013.3333px;=22>&nbsp;=20dmaengine:=20pl330:=20Add=20DMA_2D=0D=0A>=20>=20c=
apability</span></p>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-s=
erif;=0D=0A>=20>=20font-size:=2013.3333px;=22><br></span></p>=20<p><span=20=
style=3D=22font-family:=0D=0A>=20>=20Arial,=20sans-serif;=20font-size:=2013=
.3333px;=22>=20drivers/dma/pl330.c&nbsp;=0D=0A>=20>=20&nbsp;=20&nbsp;=20=20=
=7C=2044=0D=0A>=20+++++++++++++++++++++++++++++++++++++++</span></p>=0D=0A>=
=20>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-serif;=20font-siz=
e:=0D=0A>=20>=2013.3333px;=22>=20include/linux/dmaengine.h=20=7C=2025=0D=0A=
>=20>=20++++++++++++++++++++++</span></p>=20<p><span=20style=3D=22font-fami=
ly:=0D=0A>=20Arial,=0D=0A>=20>=20sans-serif;=20font-size:=2013.3333px;=22>=
=202=20files=20changed,=2069=0D=0A>=20>=20insertions(+)</span></p>=20<p><sp=
an=20style=3D=22font-family:=20Arial,=0D=0A>=20>=20sans-serif;=20font-size:=
=2013.3333px;=22><br></span></p>=20<p><span=0D=0A>=20>=20style=3D=22font-fa=
mily:=20Arial,=20sans-serif;=20font-size:=2013.3333px;=22>--=0D=0A>=20>=20<=
/span></p>=20<p><span=20style=3D=22font-family:=20Arial,=20sans-serif;=20fo=
nt-size:=0D=0A>=20>=2013.3333px;=22>2.17.1</span></p>=20<p><span=20style=3D=
=22font-family:=20Arial,=0D=0A>=20>=20sans-serif;=20font-size:=2013.3333px;=
=22><br></span></p>=20<p><span=0D=0A>=20>=20style=3D=22font-family:=20Arial=
,=20sans-serif;=20font-size:=0D=0A>=20>=2013.3333px;=22><br></span></p>=20<=
table=20id=3Dbannersignimg=0D=0A>=20>=20data-cui-lock=3D=22true=22=20namo_l=
ock><tr><td><div=20id=3D=22cafe-note-contents=22=0D=0A>=20>=20style=3D=22ma=
rgin:10px;font-family:Arial;font-size:10pt;=22><p>&nbsp;</p></d=0D=0A>=20>=
=20iv></td></tr></table><table=20id=3Dconfidentialsignimg=0D=0A>=20>=20data=
-cui-lock=3D=22true=22=20namo_lock><tr><td><p><img=20unselectable=3D=22on=
=22=0D=0A>=20>=20data-cui-image=3D=22true=22=20style=3D=22display:=20inline=
-block;=20border:=200px=20solid;=0D=0A>=20>=20width:=20520px;=20height:=201=
44px;=22=0D=0A>=20>=20src=3D=22cid:cafe_image_0=40s-core.co.kr=22><br></p>=
=0D=0A>=20>=20</td></tr></table></body>=0D=0A>=20>=20</html><table=20style=
=3D'display:=20none;'><tbody><tr><td><img=0D=0A>=20>=20style=3D'display:=20=
none;'=20border=3D0=0D=0A>=20>=20src=3D'http://ext.samsung.net/mail/ext/v1/=
external/status/update?userid=3D=0D=0A>=20>=0D=0A>=20aatif4.m&do=3DbWFpbElE=
PTIwMjUwMjI0MDg0OTQ4ZXBjbXM1cDU3YWNiMDJl=0D=0A>=20NDFiNzYyNj=0D=0A>=20>=0D=
=0A>=20MyMWQ4MmM3NDU2OTM2MWJlNSZyZWNpcGllbnRBZGRyZXNzPXZrb3VsQ=0D=0A>=20Gtl=
cm5lbC5vcmc_=0D=0A>=20>=20'=20width=3D0=20height=3D0></td></tr></tbody></ta=
ble>=0D=0A>=20=0D=0A>=20=0D=0A>=20--=0D=0A>=20=7EVinod=0D=0A=0D=0A

