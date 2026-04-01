Return-Path: <dmaengine+bounces-9794-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOzULtXAzGkWWgYAu9opvQ
	(envelope-from <dmaengine+bounces-9794-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 08:53:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F893756F4
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A3F304E827
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2C33B6F8;
	Wed,  1 Apr 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jQqDFXPL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6232BD0B;
	Wed,  1 Apr 2026 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025975; cv=none; b=k2/zY+fvxr4nwgP285hP5c6CcXoum3V5YiNYA8G+kZ0Tj/1p188okMiZZGHf+P+usFjn9uy3QSSL6KwT3tYGUqm+tq9OBfbXcN0RaDbrleJNFag0xMmp5BKAcc1GzM1ny5/Scq/J0IZjyeuuNZ7yGrKh9EMrCIwAYZ22607NIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025975; c=relaxed/simple;
	bh=tsXCo8kHJxaw2PHmUna9SP8WpCxHXFWUfDWgjeE1aCk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aAUHVSEZmK1y+yupvKnRb7+0lgKXCgLvxKqx0Ha+WuZhqI1k3sGdulQzxzao4zzVqDg2s4UXD4bhKw7efMi1SndXHSR93pH1OwnoFqangCzKxY4Ee+fzwRdIUy5SMmYc3kbgQj1rDdXesczDbPGoZRwpXFLtI3w3LRxQYZwE+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jQqDFXPL; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1775025903;
	bh=jdSh7Gkw/dQvbevK9ISn2ljXK48jqiWBgsjGy36WQ/c=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=jQqDFXPLrpAGxQZQu+WsloIN51XWDD+ZO4a4UMAweMsPlqhjtwmLznjOrZMMJh6C6
	 n3QQYFDoS4iLU8O1ZReUCsNmwyyttIb5lanTRgAerRGgouoU0GEk+Ch+/EvRH8SF4o
	 xsN/dhgdHQFZzbPzlfdKvsfbPZvfmZFw+ciqOVHI=
X-QQ-mid: esmtpsz18t1775025901t2af1da78
X-QQ-Originating-IP: rNVcEvc/xIMzFngA6uKPDU8Cfui6+G/HVk6UwmFySyo=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Apr 2026 14:44:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1209826560755650584
EX-QQ-RecipientCnt: 21
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 14:44:58 +0800
Message-Id: <DHHM60NUGNZP.1JLBPAHKZRQFR@linux.spacemit.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Frank Li" <Frank.Li@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>,
 "Guodong Xu" <guodong@riscstar.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
 <20260331-k3-pdma-v3-1-a4e60dd8b4b3@linux.spacemit.com>
 <20260401-divergent-magenta-dalmatian-3c6c3e@quoll>
In-Reply-To: <20260401-divergent-magenta-dalmatian-3c6c3e@quoll>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N9m5DZSiVOZbSjfBIAHCOaI9580cNFua75cW6peU9XPs/5ClY9v4OmN4
	owqev2zFdNAATCFOi6twzi/iF/GqezRCQWgbLUQw+lPDiXo4wqzgKbKYl8MRq9by7EqOYQw
	e03FFqbdHOS72KDNHdlv4XNwpvBqYL+0uLu35zqzgrNgDG27HjZBEVEBo+Gg9bWGlpXSL8t
	UbPXZTbNI04bQ0KxJAJq5a3IdodTDo/yPPjX+moWowygem1dw2rlKHuhSx1km3UdUVTXuCD
	jVRjhtenQg7hbzqNI1IiUkiZ2PHXjQgRh0DdXX1/8aT6xlHTkbVu7bbUEQ37jVUB36TPQfJ
	F5uSN+zNWhpsAHbLdY+7tchj/+M5r8/HPHZtcxpox+UIwRau6U1QiJlk+shqC8EOB7K/I9V
	P3a6HlYeQR/iUkKDn/Xl7dHtvh00wW+FlSpAVegBOwF37rpAX2J3jtSIIZH+oduWaP417hl
	VraVOmHQnu00Smo4/5fr9XyVpsID8WBHjnqsKqEOpqYU+JIaY1AIAJbN/da7BlBimMYKQcz
	ncG5Rd3XBoHkxoKECWLBqRdYRldT9WnUXeIBEuOglG88MG/8rP0NOFEB5K77LQylvsdP8Dr
	6EcdWQTgs7E4bz1CKoCE+TBdI3u9OpnUyVlNYBIs82/qwgvJsYHohy22JJnB+vkWqgnai50
	OYg0pZ6nM3sDeL93DoNHTLEMAucqxX5KVpHlZonGFw0/YulAw3pXpXYU3L3h/dLdVxbAb8h
	y9uYn8QWvM7OEPEyGjHRN/YwjWUVUle4tiXfSQ9Y0mg6ynGj5gc4X90yh3ejufllkhN1qPd
	XwsR3tcsRoRUQx6F343MPF/+7SyGUI5CNhDGGgW0fwY2OCjaonTquc+Q6ak3dVNeuVMDEkm
	IzojDah2TDJf3Tdryf5ryhJ2X6CsAw5JnXkRgWFRFB1QYuBTlKMnbkEtQacaHAwLzk5BMCc
	awYWLgI7fBE7+X3mkB9vJCxvMVifTX439yVHnMHlvZ916oFaSn/QPilJSLHZxW+QvXDuMLb
	UuJNILu1yea/cQorlRbcFt/yLfBZDHlQU3tjWN0Zs3dIJsZb1S/nXMrO+Jl6PkD0jf8Wfxl
	d2wpM3aEKSYDAh6BbNKrQ0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9794-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[spacemit.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid]
X-Rspamd-Queue-Id: 66F893756F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 1, 2026 at 2:42 PM CST, Krzysztof Kozlowski wrote:
> On Tue, Mar 31, 2026 at 04:27:04PM +0800, Troy Mitchell wrote:
>> From: Guodong Xu <guodong@riscstar.com>
>> - Memory addressing capabilities: Unlike the K1 SoC, which had memory ad=
dressing
>>   limitations (e.g., restricted to the 0-4GB space) and required a dedic=
ated
>>   dma-bus with dma-ranges to restrict memory allocations, the K3 DMA mas=
ters
>>   possess full memory addressing capabilities.
>
> Programming interface is still compatible, regardless of memory
> addressing limitations, so that is rather incorrect reason.
I'll remove this item. Thanks.

                            - Troy
>
> Best regards,
> Krzysztof


