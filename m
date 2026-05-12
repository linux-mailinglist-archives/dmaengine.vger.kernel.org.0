Return-Path: <dmaengine+bounces-10338-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNqNJ4mXAmomuwEAu9opvQ
	(envelope-from <dmaengine+bounces-10338-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 04:59:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C15191AB
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 04:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C083068ECD
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026F378830;
	Tue, 12 May 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0iMKBqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148337AA70;
	Tue, 12 May 2026 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554622; cv=fail; b=AWmRASAzTQasZAGNh2QuV4nlikAdU4gR7j6DWL8B5WMcoTsOiBeICdB1aLaqYVsuiAIIivN4pwYsxVLszwtE33ZTgmQP5KoMqU623Bdu7PWXL0qx0UZZOF/5iyHTlkuYpAK0r3S632bOjbpgiVHQ/g563DvpwHO9C7QbsuWci7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554622; c=relaxed/simple;
	bh=pkLpq0YkmQwmIEWeMoHLBiqZO3ExyF7LLMRMP9F3CNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vm5FtHPxrOyR5MKZ5vBCNy6/HH5oh0LVRBwRQ4llKOOfqZrSALA9ODabIxXfrV5k9Qt5t4IZyxOJyorDBLE2G0s/jrbP86U8VCcTMPrSz0nfb4xQE7mLLBtc+vbGkc+SFnwQFAJzzzI5OT1HgeZGcNV6NepS8xNxnjFhyZO4UYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i0iMKBqD; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljwebpQxParQKqTnSQpkYNpkxpqzBB5zXyggCQTFWMv4uMvRe6D1XxBhLx70ve3r8kD9aoFZoL6I0MlkDFLJQKE9Cy3dfDA8M7Xo6Sz56ORYIPM7z3ia+QadO+2YputWg5efzXRSlHUjcfeRS7b9vFazNQ6JtbY9Nul44pSJKmxpu64DtAH7INiAyzcfR4jnZ5mfPUPxnMrxli/u+kNuqqJrBarIL2uumwrtY0h5YuvvI+jSa4TiLEIrViFCxQmTd01QTO21YscY+5D5QCvnoMsqSDXlJcO4d4MeoNRFSNwpBgTDpXwjq4s433dy/EV4jDi2h5YlxmgBzW9rBZxyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB9Z1XISuE5TmIN+wzSo7EmWgnYHriGeI4H1K/EhnJ8=;
 b=eEb4Pyamym4ocKFJxNlp3bNJka+3HQZcY4ESB4xB3No+GRxLkD+N/RXVZYqbC+Bu8hnKA8DHTndg55+kIEp0S5t2Ea0RIGsiPL6OGPkZyZWAy5K7sxdUkrahYpUXRizvvJyroSkwIqOsNCScZ1NCSonYsxLmH4F5T479bBPmgfuA5dQEtNrqvyGK8XxIHn0vXdv4VA53Ka+4euBWlUtnJ28ASKH5EaQ7DhRnSJBbNmC5BG+zm/MV9PTM30DvL9tCK1ovPHZ7J4p/XAw5E3jS260G3XPdaIiF0wAw5TO0x4b36EqDCBHzgBqY+FS5ziastbCfz8DYqXcFlzzJGjwtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB9Z1XISuE5TmIN+wzSo7EmWgnYHriGeI4H1K/EhnJ8=;
 b=i0iMKBqDCDZ5li+h2EM3uIkh8Vs0s6qHfX3sH+quHmuZ2MF3Pjn6F8nZ9fGXIj/qLn3L/zpACEWCXaG/D+r/2GE1o2SjFSQgTNSd9eDdcm39Vm9a3UoON4USBqwvhigEwpcA2p3KJCKkYTPVK9tmrVTBTHNo1RSESldpDA5aXWN5HP+vJht7ZjLnjgqKujb+zR/wOc/0au/Bk+m/KOpKwl4+/bkZaDRqWU3o9ZMZW+IMxG+0xcsyeY7NyERdSztDFXgrN8caj5mVJqstmkds59M4bFVtq6e912gx3QwodZqhDn0Zc8udedKuIEjSKsTnFgMiBdbm3rzdHV4kq77CVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAXPR04MB9023.eurprd04.prod.outlook.com (2603:10a6:102:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 02:56:49 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 02:56:48 +0000
Date: Tue, 12 May 2026 10:57:59 +0800
From: Liu Ying <victor.liu@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Heiko Stuebner <heiko@sntech.de>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Parvathi Pudi <parvathi@couthit.com>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	"Andrew F. Davis" <afd@ti.com>,
	Hussain Khaja <basharath@couthit.com>, Suman Anna <s-anna@ti.com>,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Erwan Leray <erwan.leray@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Roger Quadros <rogerq@ti.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
Message-ID: <agKXN3Nmfqcdu8XZ@raspi>
References: <20260511165942.2774868-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
X-ClientProxiedBy: MA1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::19) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAXPR04MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: fae848d6-322c-4c53-1174-08deafd21c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	i65/kxoFCtN8uVYhAkDIwx6i4aXCDz8yhOgmByjJxx8iqrRME3ifmpANzfsXijKEiIUm93iNUbooyZssin+4SeeJAYuDYoHNp8ruFz2SBCC+KMoUElkoBkR6UDyBwZwmfapJkD6026qbu6bjDVNPoUXWZd2tydBt1SfyxgVTcnEZQnWhG5hBAyZa+iVwICsXD+zjLq1oykP9Crxxqc25rzvog56dpuz7q8k9cQ6R1xj5+WS2WUa1ZJWE7Yw4ij4wg9WMag5xnSn+zAo/S9SchXbGhQSEpakiv4KWDbCoWtNQhGhZQXKXkiICROP+jwNffAbV0TNfSj2JHW09rKbJAH36a5b7y16wwsxJF+funirRN1YoJZ1F9GSMePKANv70k8Nmsd1pT1CMMd3Os4RYvClPwda9QyR0dnmpdkaNGS4sPP0zTXLBPPrd5HnUqrIVIJjEpel38TqLyE95/vhpTLl1KFh0WQQ7b4tOEunpngSteTjLXeIOzM+JHhxJrmxUCXR+y/601lISVlZcJ1lNBDCXa+vwfPEKp2QW5M0zsrtyQZqHEB5d50FgDs9XqsTCoRjP/1RvujCL157ODD1q/Tj3VoGwBJ863Ph36AnDWmHqUfRq0I6XGqjdrN0487G9kfqCeqv2IaSAQec/9iYlpdonSzjhUynUNY/rc/Wp15mR+uf2WdRltdVWsKPuZvwh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqDaVSi8/2cSWzMoof3hJoHqJ8Akda0YefkoOhWp5frsAFmOLN/C40sMnJ1c?=
 =?us-ascii?Q?iRk5nLOKLDBaPZYEAaFqZ+6WNUqZsaBxR4NDraO1BCL13cWwK3CZQIAsWZyu?=
 =?us-ascii?Q?gx/vMJhVG5q3pi/XbkAOY+9UFJMOyaH7ck9f0E4pAU2RScfXjUngpLHaqHap?=
 =?us-ascii?Q?mfTQI+/isiCTfp2qJmtHobLvkoxpmQ25+kfb0oGQZ5wdvTaS/p3siGV8g8Cw?=
 =?us-ascii?Q?J+U4t2kAEXaDQWApPS1GQq2kl9d6xyCo6qMOjGFvixGQ4+Xfdi+PwiCPbpbt?=
 =?us-ascii?Q?uLz/g7zW5rS+RpyWzcNsMQO60a/qL32LMz2IFNrSK2FWtcXGwzbgd66nO6PX?=
 =?us-ascii?Q?kcGq0gEPqfHFFjaVdYp++dOw7gx/T5BPA16WMZLQSrhCtImc6HpfiS4uFAev?=
 =?us-ascii?Q?HdYP4pzffXolHjv+oKfguMm7cgc+2XG1QbmenQFn+Q5hActpPxB8afbolm2r?=
 =?us-ascii?Q?KGdK/zEeC+jN55hWBmjCep5/jqHbBpa9PMVJfmer5h5MHkPgPL8DQ6euVCVL?=
 =?us-ascii?Q?DuXUcjGTdk8EqDpjVhPqfOVJ15kdGiFtwogjZBN5/nKUJ59k151g5JotW+pa?=
 =?us-ascii?Q?2239PqNfYRMr1ThNBvSMcEXJS5XLkMrYN+JnUOoiLjvsX/zcqpS0GkZIGYgz?=
 =?us-ascii?Q?JDuVEIo/pqlfJp5dSq1s0uHzUSjiwDoztbZQAAWG+GHEBR7NZa3TPwYnbXuD?=
 =?us-ascii?Q?Dw/8XqvBu61rm5GKNAcG/kPNbROngtBN6TUE0HbXv8vHpzQ/GMO3pkEytMZl?=
 =?us-ascii?Q?DmY8o9knZ0d9BzeB3POofqZY32JA2bMvcTI/VvmN0UWw5wXqCezM8OuIgAzs?=
 =?us-ascii?Q?tw2fpkJxrbVnyuGGuYDUZjFkkVXDyfQE0NhzHVcWj99B8UWDHNeg5FpEBJrr?=
 =?us-ascii?Q?9Hunv2nfXSxE8xfr0DgY6M2bPBLuwm1m8+jh/w7DhmSaLZUEQhJP42LvFGwt?=
 =?us-ascii?Q?1UQqFXXqFscKWpNUWsRbUWlpN9E4JTMiluYAXRlMRQsMkS2Fk/LjXfVYROCx?=
 =?us-ascii?Q?Cv+fRzAxs8G3tffVvK1hX13EDWG8ZDHVaMmQCaLBz2ueeHGo86FH4jGQRaQx?=
 =?us-ascii?Q?8jNVua1Waq4jMKmaMg9SnqyuXoUPGsoWX7CqCf4Vg2PysRl4zArreDgrBdCG?=
 =?us-ascii?Q?KvW7NNy/cVMgmscLC7qtKUa6IiFmUF8RvHIJbUn7ZCrRTlKKcU4nBoMCweIW?=
 =?us-ascii?Q?sgzJmAFy+/HAgN3zBR9u2zjvwCgtorj29wz3bAtxaUxOalaeNAQQPBRlgaLy?=
 =?us-ascii?Q?x+B7ZgYaCnJNK7r/9IjIu/yPPmMy1H6AXwNYd7JFy25PKH6Qa9nhHTQ15CXZ?=
 =?us-ascii?Q?FVlB9n4sVsSasOZVSJSTucLquHOtf6qaLFiyjrDt51JpZgCrYf2Hv2bvB26X?=
 =?us-ascii?Q?wuPSz0e+vK/Rbl0ohQJA+PBSiLSJXJGfylhNFM2VZPv75BzYrjeiNd+AHBR5?=
 =?us-ascii?Q?+GK1LY8YFRx9FGfPexkusYOxKTmOdG3lpFCHUUCzdXY4pxR40HEB5HfPY1/p?=
 =?us-ascii?Q?oNjT01A9vVCIpPuELU7Fv42bdXH7MmfNYRLTFaRCs65ezYS74qWIayTiXdti?=
 =?us-ascii?Q?UFElTtQjNfVl/TTDKkr7+i6HhH9eQ9gOnNprMJwB3jflijZSOYQiJfM4Gqyl?=
 =?us-ascii?Q?ot7ZZiUPK8dOaca8lg6Xs+2/O8uVEQCE9Ra/1r5vpVpRtu5ZE6w7YZ/c85Xo?=
 =?us-ascii?Q?dsqR51RTJ3xjzx1kEY7HTfMQCoH9AHgXcPwfeM7/ZBpmQpnNayr36b6CkNbX?=
 =?us-ascii?Q?54DsVfYq8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae848d6-322c-4c53-1174-08deafd21c4d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 02:56:48.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujWXCB0yCLO6GHxiUCgb/xLJDnkArGspbiq1fTy9hRS7tcGIMY11BXjON09xMtd+4uLGrsCR6DShxJtMKl1wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9023
X-Rspamd-Queue-Id: 097C15191AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,nxp.com,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10338-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor.liu@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[79];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:59:36AM -0500, Rob Herring (Arm) wrote:
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml |  2 +-

Reviewed-by: Liu Ying <victor.liu@nxp.com> #fsl,imx8qxp-dc-command-sequencer.yaml

-- 
Regards,
Liu Ying

