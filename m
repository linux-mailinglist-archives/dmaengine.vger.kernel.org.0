Return-Path: <dmaengine+bounces-11124-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8W7yHyjzHmo8ZwAAu9opvQ
	(envelope-from <dmaengine+bounces-11124-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 17:13:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C150F62FA46
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 17:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=foss.st.com header.s=selector2 header.b=eUA1Apos;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11124-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11124-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=foss.st.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D87D3455220
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C43FA5FA;
	Tue,  2 Jun 2026 14:29:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E813FA5E1;
	Tue,  2 Jun 2026 14:29:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410585; cv=fail; b=aboEirXYHOWiR/I++J3z+bDIQQXwMJ39/4FMy9dBQJm+w5xJtuPNfUIHYDsjL1gc1QLI4HaOYXp+2YEXp9Zp94+wb2HBSR/3BmHWmQNrghsjB+Lwz8XYUZTj1Fai5C2yvvUATyENctQD2SretiAFattlVd1+sogOKF1krOqs4bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410585; c=relaxed/simple;
	bh=DR1BWfOVEqxFHe6S4SUP4vLS8mS4iXbjJ4fdfE1NcFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aIWe72mQwgaqwtDMM+Xn8azbPB2PCnvjm3XO/hyTrz3uLiJFkAZo+GzNhwOmM4OOv8bdObw6wN8vgGtzrcinA+5jURuUq/f4pTYjw/jYGRPqcqDZ8HMLugPen5pnWqEyFncZxHWBW4sucNtWvQW0/K7mOWaS6fXS3lqzYHYX4jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eUA1Apos; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAjC7cViLDG/A+FtzEsWD40JzJhWGHc24dS8Nfaez/jCMKtoN7Vo+Fiqn4tmuhHV+hUAEWv6z2C8gog/8uBoujgU8xnw7VSZv7sXf9UY3e8FmuLJdenO9mRgjlPEFHlrd6ukfsaCH6QL5yVzoZs6RVCNnjFUw5BYxp5thd374zmNDjZ5RP9VGHbI84DvcqEbFma80NBluH4BtDRRWNvaDDcyPAFSZE8+uw/0InWtwzfLawNW9m1AKWkWNC1FzELiIqfXGOYXkE5lm0pwJ79dMYDf1HXQOUKX9GaLlnHrFUNfBgEPBFeyQfWAZaQ5DshBCumvkPsZkpCkEMx9OmNhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DFoeL/DBkSdNltDI2+oyIzqYORaDpNnOZX+SZizLn0=;
 b=VI0FGGtZwdSN6Kogp6RRIOi7G/aMwOVvOxWZO5dBoI9mwUT3+Rf1tyyS7iEBnzo43q7BH2doEMOPsa7RiZ/QelWC192paHuVb0U/dnqnRU+xePK//9x3W/BSpU8stNl62FImUlCJdOoH1eo329BRBy5KujjcNZH86U84EFhX+KLtTozPF+lFNCCEKCLmSjVIbyIZURfYAKjYco7/QU6VDZyin88v1NwcR1yWyCcYSfdIJ6BqiZts4PwXlDiPamJesGw1G6tiD0unb0py3GVvcUClPkNj1hoJ1Uu22y/upCberkjKOGE7/sis5DjfESQIk7i8VE7JjxMXsMfKPyYF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DFoeL/DBkSdNltDI2+oyIzqYORaDpNnOZX+SZizLn0=;
 b=eUA1AposxWT75qtkT6GUYvdB+9Ir3YCiWqk2qPr7TMy/FsxkiHdB48k8+dsi3J2popcWyNJOk5vaq46g1BgKzgvtEYqt+Xu3npQcB9VfBRiOlThzGtE7XeFUscikNqL2Hb2yqFbHBVo48AResFP0SGvw9t/WtfnGizvzYALXTSCPsomOaQUhhLJUe3yaDLQJ1rJLfZihUe1+UEhbmLK7LSPVNxtWXpjmmbPmHDxSOPN5N85lqPdj8WzEEAo2C2xK2VgbA1kRDOwRuUXLoQd8p0qbv6fi8yAi0iDZCkhYKlyo56CFr6FV28ccjXryDSB68kFS4qRI/+j2CWqp791DwQ==
Received: from DU2PR04CA0246.eurprd04.prod.outlook.com (2603:10a6:10:28e::11)
 by AMBPR10MB9320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:29:38 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::5c) by DU2PR04CA0246.outlook.office365.com
 (2603:10a6:10:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 14:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 14:29:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 16:33:46 +0200
Received: from [10.48.87.71] (10.48.87.71) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 2 Jun
 2026 16:29:33 +0200
Message-ID: <14358d35-2ce1-4d7d-8bc6-e40da4d9b75f@foss.st.com>
Date: Tue, 2 Jun 2026 16:29:32 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH] dt-bindings: Consolidate "sram" property
 definition
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-spi@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>, "Liu
 Ying" <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
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
	<heiko@sntech.de>, Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Roger Quadros
	<rogerq@kernel.org>, Parvathi Pudi <parvathi@couthit.com>, "Mohan Reddy
 Putluru" <pmohan@couthit.com>, Bjorn Andersson <andersson@kernel.org>,
	"Mathieu Poirier" <mathieu.poirier@linaro.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Linus
 Walleij" <linusw@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, "Felix
 Fietkau" <nbd@nbd.name>, "Andrew F. Davis" <afd@ti.com>, Hussain Khaja
	<basharath@couthit.com>, Suman Anna <s-anna@ti.com>, Ben Levinsky
	<ben.levinsky@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, Erwan Leray
	<erwan.leray@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20260511165942.2774868-1-robh@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AMBPR10MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cde00e-6949-49f5-f185-08dec0b3601e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|18002099003|3023799007|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WoiZQnXY9lhhRT/z5Y5Rj899Io6tIuOZN55x3x58LjDRWY5RlNk9AQa4IA7TQ3NNzyyqW9LngKLlE+LfMfTR0dRgMVizKHQ67jyGzVEcx1nK+HmDoUMgFal0lIpnGix/1zOLQG5Y8vcnY/IH0SQRqUYNJ7ebfq4dm+PhftmCxOZZAdzPOFF0GdcT6LdnuiDTNYoNenB7QbBDKtB197gnjxCIt7RbxZ/YTygbe1CURVoiPGdoc6uzGaV9GtRYNdWWyEhXnbhu4DEmlKpVxjYR4r+M4stbcGWUnMdog+DiyPsuYWvIKRf9gPkGVUzVnZvoffUKFrGLQrTFk+3xOogq+KxJUenHqYlUqjRQPVM3Bt7DD3+3ZCArV3uxqIz1WX1z6pGmUIdSqDIDt8SrHg8lwgxcwKko/GQWlrCdmDc0RZhTgXAMNRFxTbGi2QcLg8azQAjeRhrKy1fkncIz/cfRhsHUh+LyvJPUmc7raaI6pypyuw9lflSGzFMvk5DLYD+scxdW5Uvm2vPdFsameWpCLSK3hEC3mgzZWjlXtZs3mtrYwg59ey8PL51pn0R24iw5sJif1caCl82GdS8VVBKugGJYgbOTE8RBNrglBvUedmb9ueDS79yHFNNPLIwS++lnmo1DAlJgXLutRxnGGwkC+o/2PjcDyt6Xc//Iz2pANUTFtX/h6JzYhg4oHr1qDuvrfoEwxls8HoqElVmqXbDoUnL2666hSnS+XP1FYqU+tZY=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(18002099003)(3023799007)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jagGbSISWk6WVljYbqvzNZeMQmXF8wnwolT1poC4IPw+kZnaJWOAvae+By8ALFkwZX3ScvkRDexX+MC/qfuFMgZCeNiCBhpQNcNK5wR+JpMVswGDWFPorUXjO+JGL+08nUJuRwfjG+Od8WcO/J1GzR+70eGjwwmAQYajjOni8eY72yCWfs3LtMwQptyN+8b3YfsncxwDsZHV5F6M+6+Gavs1T6oCEacPSj3XuKq0QIu/zBvVpZSpaLUVOCeu3EYYGUV/vT9VAtzdiHSMUAhWJXzKRE26xqOT0WXe6QkuS/U+A8fSLo8e3jViDM/StnOJcbR4rNhh/tKgU3zmTiWbnhYcXE61cRDTKGsLGOKauXdsZ6JkozjOta7d+c0Wo/RJX4bxubydVeIG27LcE2Xe/yHiWw0YXCWaKo9/8iANXE7tJFn+kIM27xOO9u5cQx5e
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:29:37.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cde00e-6949-49f5-f185-08dec0b3601e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9320
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11124-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,st-md-mailman.stormreply.com,ti.com,nxp.com,pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name];
	FORGED_SENDER(0.00)[amelie.delaunay@foss.st.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:devicetree@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-spi@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-media@vger.kernel.org,m:freedreno@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:rogerq@ti.com,m:victor.liu@nxp.com,m:p.zabel@pengutronix.de,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:konradybcio@kernel.org,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:ab
 hinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:vkoul@kernel.org,m:nas.chung@chipsnmedia.com,m:jackson.lee@chipsnmedia.com,m:mchehab@kernel.org,m:mirela.rabulea@nxp.com,m:detlev.casanova@collabora.com,m:ezequiel@vanguardiasur.com.ar,m:heiko@sntech.de,m:hugues.fruchet@foss.st.com,m:alain.volmat@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:parvathi@couthit.com,m:pmohan@couthit.com,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:michal.simek@amd.com,m:broonie@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linusw@kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:afd@ti.com,m:basharath@couthit.com,m:s-anna@ti.com,m:ben.levinsky@amd.com,m
 :tanmay.shah@amd.com,m:erwan.leray@foss.st.com,m:fabrice.gasnier@foss.st.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,st.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amelie.delaunay@foss.st.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCPT_COUNT_GT_50(0.00)[80];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C150F62FA46



On 5/11/26 18:59, Rob Herring (Arm) wrote:
> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
> 
> Signed-off-by: Rob Herring (Arm)<robh@kernel.org>
> ---
>   .../devicetree/bindings/spi/st,stm32-spi.yaml | 10 +++----

Acked-by: Amelie Delaunay <amelie.delaunay@foss.st.com> #st,stm32-spi.yaml

