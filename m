Return-Path: <dmaengine+bounces-10471-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBOdBN3rBWpAdgIAu9opvQ
	(envelope-from <dmaengine+bounces-10471-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 17:35:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203D5441F9
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5BBD31954FF
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB930BBBC;
	Thu, 14 May 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vL+gf6No"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4A17BA2;
	Thu, 14 May 2026 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771932; cv=fail; b=c87e2JN+yrnH44j3uZkbvYawRKbLHt0Jfw9LqHM5F/kuQrI1iO6mdweFtTFP08ugwAsTjLl1nhRLhngyaK3XjUEcpEJpN/kp7GhSrMHqgZi5EJdB6H4rO+MNAM8Hf6pc7orv9VpDRecBsjZ+TSzb80ZrnEx84QdRL0PcbALoa30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771932; c=relaxed/simple;
	bh=ajLMzh+pBn92swo8UlsN9RN/bV0m9YZnirioTSFGx9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nncnp6/qCGKU+3q6KdNFf9Gq/vDiuAvVDmfYR8tdN7KV4gKl0+cx98G6Jm9dlRMTmROHMA9/vXqdwZOJOx/+7w1nSRQDyo8WIePpN8LYlW1zyRNFrBxTfcA/IBciHtC3YSdmmiuXg2xlNNTw2e/iuL5ih8TlhWsTv2HZe3LxK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vL+gf6No; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXFrWPquLzE6Bpef/4RtSQVmrOwJ93jic1ZLvYEPTwD4xf8uQY3OCRvvQI9J4O2/Uwwz/d9YjkeANz6ApEqmhoCFQCI5cvh53b8T21rjMVu+t+lpZZ4sCcQwtVVWrdQ5+cYPLDt9rkE9mNQNHoRR4gQ20QRxJ05XsmYh3+g4mjG1HHXDaK7SyP6ybGXipi0n/b1SWz5ArFBg3WctPPD/AY1B/KX9gAnYK5PItwegJkcQmr6y/fZIaWYWZ5fgImlVs6e0wxjcxEHDaPVJRsqE+quURjVGiFrhnX55TPO8dlp5qFwu9IYv31UbVPom1zaU/BfrWuhxw7ven2kynxpQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82HPIZb934xq7hP0IkNiKj+xuQ4pFwyQoeWjUNdr8fQ=;
 b=QNX0+RCjM1lHkRq2nxEUWDdX88oVmqVxHSSEz3updK3mG3rR6CWs6/hE4xeUT6XuXLgZNFAK3Oe9PsO5RJO3wSy4/dqePJ7i+5pj3aWfqmP3X51gLMTHNnDRwBdZKLktU/CB8AkUacUX6oixaQHk7MQ6FahS958u2gK16HlMctuGbQ6PIhvEeCyDHZUKDVoc+nxdGJ1AJOz1c7VV3MrukytmKWTrLaW1QlKJhaU/bb1b7h1TBCiZ/VdPxpLanDkRNva2cynaRUfyu3egWw9irhhBdot/wduNG1+1TrpG8/nkxqcpUuhQ/Rl2e04g17fXDRZviZosSs7Dli93LJvpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82HPIZb934xq7hP0IkNiKj+xuQ4pFwyQoeWjUNdr8fQ=;
 b=vL+gf6NoL+H3q3KvdmMHNuRjpIAsIB8CgepqSku9FN/fJpOS7yjYAFyX5a9bmCtqB6MHrnk0biYen2SYAfw3zSLjay0XcYUUdwpJhPTDsjP9imPEv4BqkweBuZw4e1yQNx9NNV+y1upZkxWPgI1ji/dJsWgJJCBaCBMv7wwZf58=
Received: from BY5PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:1e0::36)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:18:45 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a4) by BY5PR03CA0026.outlook.office365.com
 (2603:10b6:a03:1e0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Thu,
 14 May 2026 15:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 15:18:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 10:18:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 10:18:25 -0500
Received: from [172.31.11.23] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 10:18:20 -0500
Message-ID: <f2222868-fef2-4a40-be1c-214020289440@amd.com>
Date: Thu, 14 May 2026 10:18:19 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <tanmay.shah@amd.com>
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
To: "Rob Herring (Arm)" <robh@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, "Akhil P
 Oommen" <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
	<jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>,
	Vinod Koul <vkoul@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>, Jackson
 Lee <jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Mirela Rabulea <mirela.rabulea@nxp.com>, "Detlev
 Casanova" <detlev.casanova@collabora.com>, Ezequiel Garcia
	<ezequiel@vanguardiasur.com.ar>, Heiko Stuebner <heiko@sntech.de>, "Hugues
 Fruchet" <hugues.fruchet@foss.st.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Roger Quadros
	<rogerq@kernel.org>, Parvathi Pudi <parvathi@couthit.com>, "Mohan Reddy
 Putluru" <pmohan@couthit.com>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>, Neil Armstrong
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
CC: Roger Quadros <rogerq@ti.com>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
	<dmaengine@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <netdev@vger.kernel.org>,
	<linux-remoteproc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
References: <20260511165942.2774868-1-robh@kernel.org>
Content-Language: en-US
From: "Shah, Tanmay" <tanmays@amd.com>
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: tanmays@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: d5794162-9094-4f75-6f33-08deb1cc1728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|3023799003|921020|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	j434hSJwySlu8HAmf+PxHnPKbC7mjagUUc/NDouRkBkY97/dERW9Z3NdALbm64PVV7jZ9WcxXqu8oGDc/M7KIwlzrPEHBuF/eKy8fQId+tAStvKEy7IS9M5aDTW6rrbUA5EDR8Ql4vUbrf8vMWCETcxjglknUVjl4J+gKiDBdhp8dK+CrLmUJwPOjQkPLSx0uqfc9tUdN6R5grhq0JKZWcdTmX5J63ARD4yecvv7nMnU41Z8zo2WJvYl3NEF7Hv2I/EscDrZ+6vRhFKDt3iA05aGj+AHrIGEH37gEiY3caacAUTiWwYle6TXpwKh7CHhYPBfmCJutonDk6XawnLsmk3sNPcM2Lj7ZG9wiFKyPx7JB9sLjHzsCNXWvgw0EC3CvS1RE5b6xPxK73dHkRO+WuYZKaefyVgsFgI/wdbSuZqbdffTLcE2ouzESZNwLcuVHsHmpvOAy2kls4ZAF3c5Z4AKJ6RdxHJwzsd1sdSgNvIX3QonUe5QIES8G6JscyGdeUjY2EgHkEQaNqsZ54K85xA91+Z/PE5Lisw85CO1dVKnHSdQBnfVLlEfshtWXpjUk5WwBtG3N7eaEJgFA0tAI5r8er+kM88320VKcaX6MFfowambZD505E4gVUDT9YH/teLrkQMnDeIvOfWMoWJXvTRU6Inf28FvEDfO4F2UatvgqbmEHxLWeTD7xB3arbyDbe3vE+Tztg2yt+U9nTAj56SMPQodK31lktZQfnXeUFo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(3023799003)(921020)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zexsxn6b5AthW2x+zN0EYG9Ngq90bzd6CSKZTo2VzAp9+IndlYFtjc0S1vCc+1ye4M6eW/K7Eg9Ame/XU2bmjHW6AAkQg2ZXL3VWruC8RMhlz3C5NPvkT/reFIzJzDifl24yr6nscFHPHZPACTQAzhmb1+Q4EXDbvl4HuX58SY5DpG84Ypb4DnSGdq7ZVYSLlKzky88SvE0iGBXgS75cLEYbGluJ+iqH8in47hkM8OcUFFda7cC0CfcVqq6QDKcRRkWtzbItTLB20YfRJmHDuw6tH0hHLPFIAQspAVAq3tvU/L9LzCCDgC2Z57d8Cinof/v5dO170/01BJhgo11YnfWBr+ZvCVk8pjcEd69HiZDOTVn4ynP8eVudbot44W1AZB+UPC+NRQhO+GDO6eMgWKBNZItuByTgyapW2Qqdc8FezBEnikkAgkEaqUkOEAO8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 15:18:45.2187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5794162-9094-4f75-6f33-08deb1cc1728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
X-Rspamd-Queue-Id: 6203D5441F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10471-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,linux.intel.com,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[tanmay.shah@amd.com];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_EQ_FROM_DOM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanmays@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[80];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

On 5/11/2026 11:59 AM, Rob Herring (Arm) wrote:
> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml |  2 +-
>  .../devicetree/bindings/display/msm/gpu.yaml  |  6 +----
>  .../bindings/dma/stericsson,dma40.yaml        |  8 ++----
>  .../bindings/media/cnm,wave521c.yaml          |  2 +-
>  .../bindings/media/nxp,imx8-jpeg.yaml         |  6 ++---
>  .../bindings/media/rockchip,vdec.yaml         |  5 ++--
>  .../bindings/media/st,stm32-dcmi.yaml         |  6 ++---
>  .../devicetree/bindings/net/mediatek,net.yaml |  3 +--
>  .../bindings/net/ti,icssg-prueth.yaml         |  2 +-
>  .../bindings/net/ti,icssm-prueth.yaml         |  2 +-
>  .../remoteproc/amlogic,meson-mx-ao-arc.yaml   |  7 +----
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  |  8 ------
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  8 ------
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         |  9 +------
>  .../devicetree/bindings/spi/st,stm32-spi.yaml | 10 +++----
>  .../bindings/sram/sram-consumer.yaml          | 26 +++++++++++++++++++
>  16 files changed, 48 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sram/sram-consumer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> index 27118f4c0d28..fd095e5742c5 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
> @@ -41,7 +41,7 @@ properties:
>        - const: sw3
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description: phandle pointing to the mmio-sram device node
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 04b2328903ca..358759fad8dc 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -84,13 +84,9 @@ properties:
>      maxItems: 64
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
>      maxItems: 4
> -    items:
> -      maxItems: 1
> -    description: |
> -      phandles to one or more reserved on-chip SRAM regions.
> +    description:
>        phandle to the On Chip Memory (OCMEM) that's present on some a3xx and
>        a4xx Snapdragon SoCs. See
>        Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 607da11e7baa..d8f92838f4c9 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -136,13 +136,9 @@ properties:
>      maxItems: 1
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description: A phandle array with inner size 1 (no arg cells).
> -      First phandle is the LCPA (Logical Channel Parameter Address) memory.
> -      Second phandle is the  LCLA (Logical Channel Link base Address) memory.
> -    maxItems: 2
>      items:
> -      maxItems: 1
> +      - description: LCPA (Logical Channel Parameter Address) memory.
> +      - description: LCLA (Logical Channel Link base Address) memory.
>  
>    memcpy-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> index 6a11c1d11fb5..6cd33dfd095d 100644
> --- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -37,7 +37,7 @@ properties:
>      maxItems: 1
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        The VPU uses the SRAM to store some of the reference data instead of
>        storing it on DMA memory. It is mainly used for the purpose of reducing
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 18cc6315a821..6ba668aa633d 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -56,10 +56,10 @@ properties:
>      maxItems: 5               # Wrapper and 4 slots
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
> -      Optional phandle to a reserved on-chip SRAM regions. The SRAM can
> -      be used for descriptor storage, which may improve bus utilization.
> +      The SRAM can be used for descriptor storage, which may improve bus
> +      utilization.
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> index 42022401d0ff..4f38a0ef29d8 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> @@ -91,9 +91,8 @@ properties:
>      maxItems: 1
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: |
> -      phandle to a reserved on-chip SRAM regions.
> +    maxItems: 1
> +    description:
>        Some SoCs, like rk3588 provide on-chip SRAM to store temporary
>        buffers during decoding.
>  
> diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> index d9fbb90b0977..7c2ddd27780f 100644
> --- a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> +++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> @@ -47,10 +47,10 @@ properties:
>      maxItems: 1
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
> -      phandle to a reserved SRAM region which is used as temporary
> -      storage memory between DMA and MDMA engines.
> +      SRAM region which is used as temporary storage memory between DMA and
> +      MDMA engines.
>  
>    port:
>      $ref: /schemas/graph.yaml#/$defs/port-base
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index cc346946291a..6bbd83c6aaf7 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -67,8 +67,7 @@ properties:
>        - const: ppe
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: phandle to mmio SRAM
> +    maxItems: 1
>  
>    mediatek,ethsys:
>      $ref: /schemas/types.yaml#/definitions/phandle
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index c296e5711848..883033b19b8f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -21,7 +21,7 @@ properties:
>        - ti,am654-sr1-icssg-prueth  # for AM65x SoC family, SR1.0
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        phandle to MSMC SRAM node
>  
> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> index a98ad45ca66f..9370c43bc66a 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> @@ -24,7 +24,7 @@ properties:
>        - ti,am3359-prueth   # for AM33x SoC family
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        phandle to OCMC SRAM node
>  
> diff --git a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> index 76e8ca44906a..3f710433e937 100644
> --- a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> @@ -48,12 +48,7 @@ properties:
>      minItems: 1
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description:
> -      phandles to a reserved SRAM region which is used as the memory of
> -      the ARC core. The region should be defined as child nodes of the
> -      AHB SRAM node as per the generic bindings in
> -      Documentation/devicetree/bindings/sram/sram.yaml
> +    maxItems: 1
>  
>    amlogic,secbus2:
>      $ref: /schemas/types.yaml#/definitions/phandle
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index b51bb863d759..8b1ed384ef22 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -75,16 +75,8 @@ properties:
>  # --------------------
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
>      maxItems: 4
> -    items:
> -      maxItems: 1
> -    description: |
> -      phandles to one or more reserved on-chip SRAM regions. The regions
> -      should be defined as child nodes of the respective SRAM node, and
> -      should be defined as per the generic bindings in,
> -      Documentation/devicetree/bindings/sram/sram.yaml
>  
>  allOf:
>    - if:
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index 775e9b3a1938..14e6b2f817b3 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -224,16 +224,8 @@ patternProperties:
>            at 0x0) or 0 (BTCM at 0x0), default value is 1 if omitted.
>  
>        sram:
> -        $ref: /schemas/types.yaml#/definitions/phandle-array
>          minItems: 1
>          maxItems: 4
> -        items:
> -          maxItems: 1
> -        description: |
> -          phandles to one or more reserved on-chip SRAM regions. The regions
> -          should be defined as child nodes of the respective SRAM node, and
> -          should be defined as per the generic bindings in,
> -          Documentation/devicetree/bindings/sram/sram.yaml
>  
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> index ee63c03949c9..c7d5e58330d6 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -106,20 +106,13 @@ patternProperties:
>            - const: rx
>  
>        sram:
> -        $ref: /schemas/types.yaml#/definitions/phandle-array
>          minItems: 1
>          maxItems: 8
> -        items:
> -          maxItems: 1
> -        description: |
> +        description:
>            phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>            the RPU can execute instructions and access data from the OCM memory,
>            the main DDR memory, and other system memories.
>  
> -          The regions should be defined as child nodes of the respective SRAM
> -          node, and should be defined as per the generic bindings in
> -          Documentation/devicetree/bindings/sram/sram.yaml
> -
>        memory-region:
>          description: |
>            List of phandles to the reserved memory regions associated with the
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index 472e92974714..6d7d595e4ab3 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -89,12 +89,10 @@ properties:
>        - const: rxm2m
>  
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: |
> -      Phandles to a reserved SRAM region which is used as temporary
> -      storage memory between DMA and MDMA engines.
> -      The region should be defined as child node of the AHB SRAM node
> -      as per the generic bindings in Documentation/devicetree/bindings/sram/sram.yaml
> +    maxItems: 1
> +    description:
> +      SRAM region which is used as temporary storage memory between DMA and
> +      MDMA engines.
>  
>    power-domains:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sram/sram-consumer.yaml b/Documentation/devicetree/bindings/sram/sram-consumer.yaml
> new file mode 100644
> index 000000000000..f00087bd2879
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/sram-consumer.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/sram-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SRAM Consumers
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +select: true
> +
> +properties:
> +  sram:
> +    description:
> +      Phandles to one or more reserved on-chip SRAM regions. The regions
> +      should be defined as child nodes of the respective SRAM node, and
> +      should be defined as per the generic bindings in,
> +      Documentation/devicetree/bindings/sram/sram.yaml
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
> +
> +additionalProperties: true
> +...


