Return-Path: <dmaengine+bounces-4581-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6421A4773F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B51188D874
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3C16F288;
	Thu, 27 Feb 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed0Qxid+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37FA24B28;
	Thu, 27 Feb 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643244; cv=none; b=nwvRGSnZKbrGkWro+pO6fvu1oVSPpzoAWmndOrr8eIBf2Qj/vPYyrzZ9/LkdK1YhS3xXx0JpVWNKzHmdawVEiNvXFomH4xOUKhBHRbJ6SjpV1LP2/kWZvuP5R7Jjd2Gu1uYcp3cwu5xSVWRQ5B/Kd6/MpJXcHPKgUH5+OQtAaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643244; c=relaxed/simple;
	bh=s9+t4OIp5dGezQHN9ElJ8KaRQewu/1qLqmi4k+ijfx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6+KoHFgAtaHd9xQgMaDQBa2PQsJMMBRTL2T8fJoaXJFG8lrbvsv6VAqWr9UsNu6cD0qYRxKbhWMN1B7TOyAR8eXPzlE6VMJ+z6N9dIyxP5yF7+3VQgjnQ4J8D7VlLTNoHKZ/dYsKPot0T32QGkf2IzG2w7ehLVpGg9gg7snqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed0Qxid+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77375C4CEDD;
	Thu, 27 Feb 2025 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740643244;
	bh=s9+t4OIp5dGezQHN9ElJ8KaRQewu/1qLqmi4k+ijfx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed0Qxid+3w9VGbE1z4Og93eBb2ZSsbaQbykUruohCot2RaLfzW7KsILGbpncEEZog
	 A6TMLa14b3bH0cwWwcZj18+Oryvlk59zw5CPTtpVkOOmIbz1SCnWq5sETXM2JpgQGP
	 AWPeVpQIO6U4x+n74uvSEMs5mL7nXehGFpRXYIhvEfXk59+mzsEOtKBFzmQPdxXP0z
	 uc5t8xwfNfafAxgzOkcQiLRe2Re/Prkk/wGWIyElaLw5FcErjk/7lYB9r3o/hbn9l1
	 a2GanE4xATpi0AAxF2NHEYOnRrj3pzdfq59Znyl+ABcq25XE6/OVS8avdWLHpBBBQQ
	 Hhmh5dmvvPe/Q==
Date: Thu, 27 Feb 2025 13:30:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Aatif Mushtaq <aatif4.m@samsung.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	PANKAJ KUMAR DUBEY <pankaj.dubey@samsung.com>,
	ASWANI REDDY <aswani.reddy@samsung.com>
Subject: Re: FW: [PATCH 0/3] Add capability for 2D DMA transfer
Message-ID: <Z8AbqGa9lZYnWddp@vaman>
References: <20250210061915.26218-1-aatif4.m@samsung.com>
 <CGME20250210062219epcas5p4695fe63e9ba36c19a640504f95dc3f12@epcms5p5>
 <20250224084948epcms5p57acb02e41b7626321d82c74569361be5@epcms5p5>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250224084948epcms5p57acb02e41b7626321d82c74569361be5@epcms5p5>

On 24-02-25, 14:19, Aatif Mushtaq wrote:
> <!DOCTYPE html>
> <html>
> <head>
> <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8" =
class=3D"cui-content-default">
> <style class=3D"cui-content-default" data-cafe-default=3D"true">@charset =
"UTF-8";/*! cafe note v2.3.34.7 | Copyright 2014, S-Core, Inc. All Right Re=
served. */body,html{overflow:visible!important;height:auto}html{height:auto=
}body{display:block;margin-left:24px;margin-right:20px;margin-top:16px}body=
 ol,body ul{margin:0;padding-left:40px}body li,body p{line-height:1.9;margi=
n:0 auto}body .cui-quote{margin-left:4px;margin-bottom:20px;padding-left:6p=
x;border-left:4px solid #ccc}body .cui-quote h1,body .cui-quote h2,body .cu=
i-quote h3,body .cui-quote h4,body .cui-quote h5,body .cui-quote h6,body .c=
ui-quote li,body .cui-quote p{margin-bottom:4px}table.cui-div{display:block=
}table.cui-div>tbody{display:block}table.cui-div>tbody>tr{display:block}tab=
le.cui-div>tbody>tr>td,table.cui-div>tbody>tr>th{display:block}figure.cui-o=
g,figure.cui-temp-og{margin:0;display:block;margin-inline-start:0;margin-in=
line-end:0}.cui-og-container{display:inline-flex}.cui-og-container .cui-og-=
button-close{display:none;width:20px;height:20px;cursor:pointer;border:none=
;border-radius:4px;background-color:#fff;background-position:center;backgro=
und-image:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAA=
CNiR0NAAAAAXNSR0IArs4c6QAAAI5JREFUOE+9lLEVgDAIRC8b6Tw0Opk2zKMj+XjPApUABTFtL=
j9wXNJQvFoxD+OBzDwR0Zmp3NI+KhQBgAPASkS7B2XmBcAGYNYFfFpWwi7U05geegeiC7tDsQ5G=
MLHInbIG3H6KZ66/YWwUVJjhsP4FlrZcOpTS2GSikQ72qKdX9zlkfphIE+YwArz3y4EXDCF2Fap=
Wr4IAAAAASUVORK5CYII=3D");position:relative;top:10px;left:-30px;z-index:1}.=
cui-og-container .cui-og-button-close.cui-state-focus{display:block}table.c=
ui-pasted-table h1,table.cui-pasted-table h2,table.cui-pasted-table h3,tabl=
e.cui-pasted-table h4,table.cui-pasted-table h5,table.cui-pasted-table h6,t=
able.cui-pasted-table li,table.cui-pasted-table p,table.cui-pasted-table td=
,table.cui-pasted-table th{line-height:normal}div[data-cui-alt-image],img[d=
ata-cui-alt-image]{background:url("data:image/png;base64,iVBORw0KGgoAAAANSU=
hEUgAAABYAAAAUCAYAAACJfM0wAAABH0lEQVQ4jbXU26qEIBQGYF+wtxLMgg4QdGdBREUhFEFBB=
x/tn6sGpcPezTTCAi/0Q11rSQghhDGGJ4P8An3j20QIgSzLvookSfawUgrrukIp9VVcwkIIcM7h=
+z66rnsGbprGeCvf95+B8zw3YM75M/A4jnAcB3pS9Y3zPKPv+0vYKDf9jcdxRJ7naJrG2DRNE8I=
wBGMMZVkewmQbOnwVy7IgiqL3TWzbRtu2x+gVnKYpXNdF27ZY1xVxHO+awHVdDMMAKaWJnsFZlh=
kn8zzvtMOCIACl1No8Sqm1S55SCkVR3GrdI3QH13V9/7PRxmG5SSlh2/bHKGMMVVXtYc75bZRSa=
unX1w92+9vUT6mju3WfJuqvv/zf8FmZXq7/BfoCA1VRsvK4AfgAAAAASUVORK5CYII=3D") no-=
repeat center #c1c1c1}body::-webkit-scrollbar{opacity:.08;width:6px;height:=
6px}body::-webkit-scrollbar-thumb{background-color:rgba(0,0,0,.15);border-r=
adius:7px;width:6px}.cui-knoxtaskinput-line{height:150px}.cui-knoxtaskinput=
-line.double-line{height:170px}.cui-customtask-card{width:560px;height:68px=
;border-radius:8px;border:solid 1px #dbdbdb;background-color:#fff;border-sp=
acing:0px;table-layout:fixed;margin-bottom:20px}.cui-customtask-card td{mar=
gin:0;padding:0;border:0}.cui-customtask-card td>p{width:422px;margin-left:=
0;text-overflow:ellipsis;white-space:nowrap;overflow:hidden}.cui-customtask=
-card .cui-customtask-card-cell{text-overflow:ellipsis;white-space:nowrap;o=
verflow:hidden}.cui-customtask-card .cui-customtask-card-image{width:40px;h=
eight:40px;margin:0 15px 0 15px;border-radius:22px;background-color:#e96b6b=
;vertical-align:middle}.cui-customtask-card .cui-customtask-card-content-ta=
sk{font-size:15px;font-weight:700;font-stretch:normal;font-style:normal;let=
ter-spacing:normal;text-align:left;color:#000;line-height:20px;height:100%}=
=2Ecui-customtask-card .cui-customtask-card-content-asignee{font-size:12px;=
font-weight:400;font-stretch:normal;font-style:normal;letter-spacing:normal=
;line-height:20px;text-align:left;color:rgba(0,0,0,.9)}.cui-taskcard-wrappe=
r{display:block;height:72px;margin-bottom:20px}.cui-taskcard-wrapper .cui-t=
askcard-more{width:32px;height:32px;padding:0;border:0;background-image:url=
("./cafe/knox/2.3.34.7/skins/default-knox/images/ic_more_horizontal_normal.=
png");background-size:16px 16px;background-repeat:no-repeat;background-posi=
tion:center;background-color:transparent;border-radius:16px}.cui-taskcard-w=
rapper .cui-taskcard-more-hover{background-image:url("./cafe/knox/2.3.34.7/=
skins/default-knox/images/ic_more_horizontal_active.png");background-color:=
rgba(0,0,0,.06)}.cui-taskcard-wrapper-menu{width:122px;height:80px;border-r=
adius:8px;box-shadow:0 3px 4px 0 rgba(0,0,0,.08);border:solid 1px #dbdbdb;b=
ackground-color:#fff;position:absolute;top:46px;left:516px}.cui-taskcard-wr=
apper-menu .cui-taskcard-wrapper-menu-ul{margin:8px;padding:0;list-style:no=
ne}.cui-taskcard-wrapper-menu .cui-taskcard-wrapper-menu-item{position:rela=
tive;width:106px;height:32px;border-radius:4px;list-style-image:url("data:i=
mage/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");=
margin:0 auto}.cui-taskcard-wrapper-menu .cui-taskcard-wrapper-menu-item-ho=
ver{border-radius:4px;background-color:rgba(0,0,0,.06)}.cui-taskcard-wrappe=
r-menu .cui-taskcard-wrapper-menu-icon{width:20px;height:20px;margin:0 0 6p=
x 0;position:absolute;top:4px;left:8px}.cui-taskcard-wrapper-menu .cui-task=
card-delete{background-image:url("./cafe/knox/2.3.34.7/skins/default-knox/i=
mages/ic_memo_delete.png")}.cui-taskcard-wrapper-menu .cui-taskcard-update{=
background-image:url("./cafe/knox/2.3.34.7/skins/default-knox/images/ic_edi=
t.png");background-repeat:no-repeat;background-position:center}.cui-taskcar=
d-wrapper-menu .cui-taskcard-wrapper-menu-text{width:52px;height:19px;font-=
family:"Malgun Gothic","=EB=A7=91=EC=9D=80 =EA=B3=A0=EB=94=95",Dotum,"=EB=
=8F=8B=EC=9B=80",Gulim,"=EA=B5=B4=EB=A6=BC","Apple SD Gothic Neo","Segoe UI=
 WPC","Segoe UI",Helvetica,sans-serif;font-size:13px;font-weight:400;font-s=
tretch:normal;font-style:normal;line-height:2.15;letter-spacing:normal;text=
-align:left;color:rgba(0,0,0,.9);position:absolute;left:34px}.cui-mention.c=
ui-mention-edited{display:inline-block;padding:1px 4px;border-radius:4px;ba=
ckground-color:rgba(187,187,187,.19)!important;color:#2a82f0!important;font=
-weight:400!important;font-style:normal!important;font-family:"=EB=A7=91=EC=
=9D=80 =EA=B3=A0=EB=94=95"!important;text-decoration:none!important;line-he=
ight:normal}.cui-mention.cui-mention-editing{padding:1px 4px;border-radius:=
4px;background-color:rgba(0,0,0,.06);color:rgba(0,0,0,.9)}</style>
> <style class=3D"cui-content-default" data-user-config=3D"true">

???

Pls stop sending HTML emails to the lists!

> body {margin: 10px; font-size: 10pt; font-family:Arial,sans-serif; line-h=
eight:1.9;}
> p {line-height:1.9;}
> body,body p,body li,body h1,body h2, body h3,body h4,body h5,body h6 {fon=
t-family:Arial,sans-serif; line-height:1.9;}
> </style></head>
> <body><p><span style=3D"font-family: Arial, sans-serif; font-size: 13.333=
3px;">Hi all !<br><br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
I hope this email finds you well. I wanted to gently remind you to please t=
ake out some&nbsp;</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
valuable time from your schedule to review the patch chain.</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
regards</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
Aatif Mushtaq</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
&nbsp;</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
--------- <b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3=
333px;">Original Message</span></b> ---------</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">Se=
nder</span></b> : Aatif Mushtaq &lt;aatif4.m@samsung.com&gt;FDS SW /SSIR/Sa=
msung Electronics</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">Da=
te</span></b>   : 2025-02-10 11:52 (GMT+5:30)</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">Ti=
tle</span></b>  : [PATCH 0/3] Add capability for 2D DMA transfer</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">To=
 : </span></b>vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vge=
r.kernel.org</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<b><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">CC=
 : </span></b>PANKAJ KUMAR DUBEY&lt;pankaj.dubey@samsung.com&gt;, ASWANI RE=
DDY&lt;aswani.reddy@samsung.com&gt;, Aatif Mushtaq&lt;aatif4.m@samsung.com&=
gt;</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
&nbsp;</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
Add support for add halfword instruction to pl330 driver to achieve</span><=
/p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
2D DMA operations. Add a corresponding dmaengine API to prepare the</span><=
/p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
DMA for 2D transfer and create a hook between the dma engine and pl330</spa=
n></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
driver function.</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
Aatif Mushtaq (3):</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
&nbsp; dmaengine: Add support for 2D DMA operation</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
&nbsp; dmaengine: pl330: Add DMAADDH instruction</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
&nbsp; dmaengine: pl330: Add DMA_2D capability</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
 drivers/dma/pl330.c&nbsp; &nbsp; &nbsp;  | 44 ++++++++++++++++++++++++++++=
+++++++++++</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
 include/linux/dmaengine.h | 25 ++++++++++++++++++++++</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
 2 files changed, 69 insertions(+)</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
-- </span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
2.17.1</span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <p><span style=3D"font-family: Arial, sans-serif; font-size: 13.3333px;">=
<br></span></p>
> <table id=3Dbannersignimg data-cui-lock=3D"true" namo_lock><tr><td><div i=
d=3D"cafe-note-contents" style=3D"margin:10px;font-family:Arial;font-size:1=
0pt;"><p>&nbsp;</p></div></td></tr></table><table id=3Dconfidentialsignimg =
data-cui-lock=3D"true" namo_lock><tr><td><p><img unselectable=3D"on" data-c=
ui-image=3D"true" style=3D"display: inline-block; border: 0px solid; width:=
 520px; height: 144px;" src=3D"cid:cafe_image_0@s-core.co.kr"><br></p>
> </td></tr></table></body>
> </html><table style=3D'display: none;'><tbody><tr><td><img style=3D'displ=
ay: none;' border=3D0 src=3D'http://ext.samsung.net/mail/ext/v1/external/st=
atus/update?userid=3Daatif4.m&do=3DbWFpbElEPTIwMjUwMjI0MDg0OTQ4ZXBjbXM1cDU3=
YWNiMDJlNDFiNzYyNjMyMWQ4MmM3NDU2OTM2MWJlNSZyZWNpcGllbnRBZGRyZXNzPXZrb3VsQGt=
lcm5lbC5vcmc_' width=3D0 height=3D0></td></tr></tbody></table>


--=20
~Vinod

