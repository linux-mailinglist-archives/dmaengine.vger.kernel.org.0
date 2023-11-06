Return-Path: <dmaengine+bounces-53-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD287E1C90
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C1E2812A3
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7F2561;
	Mon,  6 Nov 2023 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66823D5
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 08:44:07 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F039C9
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 00:44:05 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 84C0C24E0D6;
	Mon,  6 Nov 2023 16:44:03 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 16:44:03 +0800
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 16:44:02 +0800
Received: from EXMBX061.cuchost.com ([fe80::b087:fbb:9f87:209e]) by
 EXMBX061.cuchost.com ([fe80::b087:fbb:9f87:209e%14]) with mapi id
 15.00.1497.044; Mon, 6 Nov 2023 16:44:03 +0800
From: EnDe Tan <ende.tan@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
Subject: RE: [v2,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Thread-Topic: [v2,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and
 dst_maxburst
Thread-Index: AQHZ5jIa8o2rI4fa4EKYBk4YoIeto7A5OwMAgDQLZWA=
Date: Mon, 6 Nov 2023 08:44:02 +0000
Message-ID: <5c6b1d6c73ff4b558457bf248a0d0bb0@EXMBX061.cuchost.com>
References: <20230913110425.1271-1-ende.tan@starfivetech.com>
 <ZR1optUInIcCgTxN@matsya>
In-Reply-To: <ZR1optUInIcCgTxN@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Are client drivers setting this today, will there be regression if not se=
t?
I don't see any dw-axi-dmac client driver setting this src_maxburt/dst_maxb=
urst explicitly.
This means that all the while, those client drivers have been using the def=
ault value of DWAXIDMAC_BURST_TRANS_LEN_4.
In the patch, to maintain this backward compatibility, ternary operator is =
used, for example:
> > +	dst_burst_trans_len =3D chan->config.dst_maxburst ?
> > +				__ffs(chan->config.dst_maxburst) - 1 :
> > +				DWAXIDMAC_BURST_TRANS_LEN_4;
so that if src_maxburst/dst_maxburst is not set, default value of DWAXIDMAC=
_BURST_TRANS_LEN_4 applies.

> this is wrong, memcpy should never use slave config value. These values a=
re
> for peripheral and not meant for mem-mem transfers
Agreed, thanks for pointing that out. It shall be removed in patch v3.

