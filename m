Return-Path: <dmaengine+bounces-11121-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L5R7Hr/VHmqQVgAAu9opvQ
	(envelope-from <dmaengine+bounces-11121-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 15:08:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24662E4B2
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 15:08:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=foss.st.com header.s=selector2 header.b=NI8wEIUD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11121-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11121-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=foss.st.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67C2E30458EF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA13E7BB8;
	Tue,  2 Jun 2026 13:03:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0D3E63A6;
	Tue,  2 Jun 2026 13:03:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405425; cv=fail; b=o81IHqYfQ4S4J547/PaPEhQjsAK807haeR+FJoEUZTcHx3upadG6L7r9eJwDXGCzKjEKU0wpWqPy4JUqFcgEUEAqmcKLFNP7+WGnLOfBMa7MatB1vPPq2joVVGWjFvTPC3WXDtuPXKeXyYJ523g6OoCOydRBy5fclS9ILWG+UYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405425; c=relaxed/simple;
	bh=WNFDfk7IM4HeP4yJWYiAuuv35Zgu+UGfAxKeJKO3FuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyv9lTSJ+r8Sk0u5Vi9OPkku1C/rPviz8SoCnM5YhiMAAITZ1c7+ptrXoqmaWelf5SvafeRq+A3loH4nVD3i31L0G3esc0S73rYGqDKlAiTuJvy4fidKz8vC+AxTZU6aq0h+dadOw3bQGSlQtQXUhPSGjvwBMZSxilYH3HYUPuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NI8wEIUD; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIcuGOG9xL5lZtXURPaGH1tSNXDtY6EeMUOu2I11cuDi3cmYk+W1KGxqIoIDV6UOw2fMF9mnsXQeLXWgaOD6YTCgkt0ReqHF7/jr9kJ3at5kTJfy9xRpwFWxdwG3hxk68krZGTZ7zLZW9Z9iBzXIETrzCROyOayQr+3QgqRzuS0CmVvbmnHAPwKMJdPq11lMmeyVH8D2wdj25sBY6ERPzi7k2yaPgIfa/GV4iA8TadVb0HSwTdGTLtgT8dklsNJ/SHuJs2xOYwNw/S2IeaULP4C0mrbNu99IR/pQ0RXSHlCc0yUfR5KYIRXX6bHi7CXva9t2pDGcHf5p5rfiobJN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwWwQR9P8Ympgw+kQz4842HILDOyHmzShXCwxSRrcg8=;
 b=lwyoP/0OmTEsf1fNgE7Ak7juVsrJ0qhhvJMm3gNYniPTUIgulIVRFBwt3gTMw6RDuBcdiQWSVRxZMMkB8NE8Txd14InHBSRFAA5e1qszm4inmw38DeqwNrr1W8Y2bCPAJ3n2HMrAAXXNr0ej0DNC/7p8ImCPt/qlIw21ep2+ovwx25mzqzcvNrr8JvISjem+/IchhgtVsQky1Agd6pKXUwxC8DW+AWvLb4mVzS8bH+p7e5dIvByf3pxa7d/xUNr0rHfIYPlxQOINmkAVThb6MfC7vUnhKPbkl1fGYcKt3ksYQfkLUxKklci9tshwI4nwawlTg5SUH0dJ8EiXuhNbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwWwQR9P8Ympgw+kQz4842HILDOyHmzShXCwxSRrcg8=;
 b=NI8wEIUDnGlHzXkJQy6i4GOwTPSqDsgr/hPgDJwRLWDQWg2tIzFrJWM1BJoZNvl/JV8FqpUuHAFQ1YjGwnWcVL3pUzMx3RmCU8Wnk00LeGq557H6+WPUQ2DTsqggApftkUHrODF/vAQiHKU5OkWuPk5vV38TbHaWzuP+uY/5ymfiZskr0ormpZ5denr5eSOn5221m3BUrV5C59ag/TU9KHQ2WA0JOco+iYc27lINyO7+hjkdNDt/sOuolj0CrfLjWXT/vqrKcpJSF709gSLncFausnDehHkPE+vis6nTY9Lp710a3iBdkzDRlmUieXJaN4uoL5ZkCK4C477bFr5lNA==
Received: from DB7PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:10:36::40)
 by VI1PR10MB3184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 13:03:36 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::e) by DB7PR05CA0027.outlook.office365.com
 (2603:10a6:10:36::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 13:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 13:03:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 15:07:44 +0200
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 15:03:33 +0200
Date: Tue, 2 Jun 2026 15:03:20 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Liu Ying <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad
 Dybcio <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	"Dmitry Baryshkov" <lumag@kernel.org>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Marijn
 Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>, Nas
 Chung <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>, Mirela Rabulea
	<mirela.rabulea@nxp.com>, Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Heiko Stuebner
	<heiko@sntech.de>, Hugues Fruchet <hugues.fruchet@foss.st.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Parvathi Pudi
	<parvathi@couthit.com>, Mohan Reddy Putluru <pmohan@couthit.com>, "Bjorn
 Andersson" <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michal Simek
	<michal.simek@amd.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Andrew
 F. Davis" <afd@ti.com>, Hussain Khaja <basharath@couthit.com>, Suman Anna
	<s-anna@ti.com>, Ben Levinsky <ben.levinsky@amd.com>, Tanmay Shah
	<tanmay.shah@amd.com>, Erwan Leray <erwan.leray@foss.st.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, Roger Quadros <rogerq@ti.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <dmaengine@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <netdev@vger.kernel.org>,
	<linux-remoteproc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
Message-ID: <ah7UmMC9fbWuyopl@gnbcxd0016.gnb.st.com>
References: <20260511165942.2774868-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C0:EE_|VI1PR10MB3184:EE_
X-MS-Office365-Filtering-Correlation-Id: 41804fca-f1aa-4c97-6843-08dec0a75b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nBtSLCyV1zNaj4AYS9TljJxgu9LjuqDypvz6s5q1mmtaP3SSLxCZQEWwIxiLS+VAVYAuA7oDf7K6+m40o/xOcVrotpYE/XqihZn3zsWUweEhW7kSyL3bEKN/7Y97ZY3DngopwbPo3TmdNeggBqYoDcZH+6rwDRKAMGhtmXoXidU/Q/psey30ZPXNRfuLe79Vwm5HNIdcmkulv9ymbhMEYodX8fMDNeCqzsi1lv+ekv0eBBRJ8ZzqsHGRCblhFnHO2voSiJCE+UQBFF8QDZYGMl8pVRO6Op9dZpr3mh/FWSXy1atXlI561urKBhAZEudJgsL1JocV44jQC+WzgojHZF2kh1h54yHxNJJTo90ct800Hmv5cRnEAJGdgvKUNnUMoCFPG2SxEnxQ/8YtrESRvrQalllwW4hmLuHIV6/MGFF5DGlcqPIJ2zT9vfT1M6xVyWvgZu5G6e9W5JpRns0oU8z9hx0TtYQa7FVdlfgYEGBIazv7YVFu91/eodjxRlJdrwMyO8uKkXNvqvBdgF9l2S5fZoek0ekxeULffTEBEYvVCt7AOyS9V2w9771i+gHQEJjoHn00LaVMkkGeaQY3W/aOEQCAB23In41sol9GPCJsw6oCce43TyO82Hhxq81xMeakW1CvhEVyDzKUGfo/t+RxPZflg8io4Jgs6ku3KaRZkGhOMFtqkXss3wtALDhqb4FoEPEVm1qsACJ/HnWniCNXJaf3Q8IeIqu4OJA54Yk=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aBmJ6MlgTmzNChnBehDqv9+4//tdizL6JKnMkyfjk9H+924t2l28f906bO2GWyks5L9F1PgGV4iLcesLKLL52YfzYULyiGhkgtdagr2OpLLMD3s3hTq1UXnNF1iyxFGmqherFoLIF8dWYUpD23kPWEHFY8bP1iXQVK1Nwx5UoaUuXaGb6/vNFMmp8Wym3c/Lvc5zhWgoXrFvcpLFgeH0/kpOtWEGmzbjQStWW0Isg1VqBJqlcZtRn8/8R0vZfUcT4lTpYUyZdT/FJFUnDkpbOr3oAfTbWC9097HNmAsr098j/dLKnVWY667H4QS/F1JqXOIIHyds4oI9YvtJoSyAqw3l7+893pU5Wd14tvmPY13WZr23xdEa9BZeEGaQhxaULqhZeklPswj9/zo74DOw3Q8TIu7OXH1r+PBsVTcLbaBdHLyCkdRjPSTk4Tp8zyIZ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:03:35.8611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41804fca-f1aa-4c97-6843-08dec0a75b71
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3184
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	TAGGED_FROM(0.00)[bounces-11121-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foss.st.com:from_mime,foss.st.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,st.com:email,vger.kernel.org:from_smtp,gnbcxd0016.gnb.st.com:mid];
	FORGED_SENDER(0.00)[alain.volmat@foss.st.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:victor.liu@nxp.com,m:p.zabel@pengutronix.de,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:konradybcio@kernel.org,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:vkoul@kernel.org,m:nas.chung@chipsnmedia.com,m:jackson.lee@chipsnmedia.com,m:mchehab@kernel.org,m:mirela.rabulea@nxp.com,m:detlev.casanova@collabora.com,m:ezequiel@vanguardiasur.com.ar,m:heiko@sntech.de,m:hugues.fruchet@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:parvathi@couthi
 t.com,m:pmohan@couthit.com,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:michal.simek@amd.com,m:broonie@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linusw@kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:afd@ti.com,m:basharath@couthit.com,m:s-anna@ti.com,m:ben.levinsky@amd.com,m:tanmay.shah@amd.com,m:erwan.leray@foss.st.com,m:fabrice.gasnier@foss.st.com,m:rogerq@ti.com,m:dri-devel@lists.freedesktop.org,m:devicetree@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:freedreno@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-spi@vge
 r.kernel.org,m:linux-mediatek@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alain.volmat@foss.st.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[79];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B24662E4B2

On Mon, May 11, 2026 at 11:59:36AM -0500, Rob Herring (Arm) wrote:
> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>
>  .../bindings/media/st,stm32-dcmi.yaml         |  6 ++---

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

