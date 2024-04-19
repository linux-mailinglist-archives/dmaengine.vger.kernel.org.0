Return-Path: <dmaengine+bounces-1907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB28AB157
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E711F23FF5
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54112FF8E;
	Fri, 19 Apr 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4hnQj/6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9A12FF83;
	Fri, 19 Apr 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539282; cv=fail; b=mLy951NQCY+WdzgAWtlzLNvFdZtsR88453nQ1Sy5FHUdKdpl1qjUl1Uc7w83RHhBpYQq45EX/2J+OThbCvSxAhjDI5ksAez7Rc4DZBYV6ZYIAhmDbhB4+3aWlUXtXKEURZEZqO4Bzc9jChqrHUQh+O1lWOpyNAzLdd2T/glLSCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539282; c=relaxed/simple;
	bh=u/REa+vw8Iz3svdIr0FC53hoLuuiVSOSUtL6yOIstg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mssNpLRKCUqinNMMQM3tmztbfOsy95TViGj0MYfGGwdeb49K4yXXdfwkFeZYswYZy5U8uK+GCsKc4LJsATZm0tvp4fCtH8hd4nZ6hR66ZC7ngUEXLrv0BTjTwrTd6zl4NOan12OwHEvLr1arrEx25PxIpFxvkvDL+K7ZoLrwJE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4hnQj/6; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ6RNMrnbt54+xxRKA/kS0gdjRGI5g/uhzoosDNV8zZqJFLHN/xfPM3in79gRiutO+ej67y5kAt9UBkec4nPoA7OyZLj9zMLidz5JIGZKjcVsKZ7jdbgzebDC75Q2sXnr6NW5TsxZS5jlwT9NnvdFcMuLArW1TRteNW/cZNu8ggxddogK7g0cDfXQn0oo9Pxrx33VM/wKa4vo87azpBIEGMB++cQTrx2e0KcVafuJqLJMpaUnjl4cmgcdAnKKeZQy5vcnzgXs+iizznCp1y6UT5VgP9ta/rYP+1/zEJI0YupbepeGmIAuocOZ7FAZMKqHZzwgbWy6D96cKyvJHjT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP9ldxWobQvZm9Bq9rd9KDqKFZ6xZRce7132ihwTtOc=;
 b=RSSi89DwPIm9eI9fpRyKSWZDAVITrMBdCAxd8SZarFBKhs38+GUctpsKip9IHIb2P9o9MlrbRyRbweqVSGse4Pysco3cXzpjPze6QfQLli/egCTvfgxMp68uxsN1MNfEhbQJmaiNUtz6urdV1jo/L9wpeOIcjPQA7kzyUEhUJ/uY0X8cQZsErlOB9Eb61bIQ2rf4sYwAlmsj58/M3QxUHuzTuETi7B/cjiCtNKLI79zzDhbklcHVhGGlE5zlzu44uIeYwhnwlkGWJbV9V9nfULyt8/ASgKQoy1bqznFeDBwAjOuzsQFflt5zl/lvM+gISPBYeUAdkrfhDjsdR+mhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9ldxWobQvZm9Bq9rd9KDqKFZ6xZRce7132ihwTtOc=;
 b=R4hnQj/67GzDhEbUy8CWhB+F3c1yerc7UenamvLIZyJWB684t7e831K5kEDAwvl0/UlqECgWS3RTSk4a4kq0jOU70RgYC+ZGWJiT1/s2SF/Jvibdg92SDs/erCSf65P0yVLxx4T/OZsTIfMVxdT4tRP4synE352nAcNC5pYxdFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10330.eurprd04.prod.outlook.com (2603:10a6:150:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 15:07:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:07:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 3/3] dmaengine: imx-sdma: Add i2c dma support
Date: Fri, 19 Apr 2024 11:07:29 -0400
Message-Id: <20240419150729.1071904-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419150729.1071904-1-Frank.Li@nxp.com>
References: <20240419150729.1071904-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a55c037-caef-49fe-d857-08dc60827e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWA/jDp+TsQCcfZD1A2hWfLnaaoTMpN65+juV9nCpdkC4TeuTdzGvJ20hjjR?=
 =?us-ascii?Q?YHk1Z2Uip5LwUZexu8JTjsUOa4EEKHIaTEBsoGdfMZKNlMf0g21/3A/OAerC?=
 =?us-ascii?Q?ZIN67bYZIDg/X5EH1GzjvC86Q/mtxHrdOsnFFMP4o8oPFutX9fXgbmMFiAmp?=
 =?us-ascii?Q?amK7PyobT8OALo79jwlvugm9zfvlj9Cru8BkwJ34ETtFd0nFyEpzRFrPBCZV?=
 =?us-ascii?Q?vPQECJNcem2C7pyUVaR1xhWrtG+rZ8g5ENgBxTQBrNth03JaqcrShYQmpRho?=
 =?us-ascii?Q?Ihne4Um74EItG1HtxKFtNZAzF5/hgPvjopG0SMLbdcb/BWHDxuvF/EMpU2Rm?=
 =?us-ascii?Q?3wK69jycxJyHhellJ65wrXDY+qwKQMi3mu5JNU+gzBWQap2rUOYtvWQMaw0L?=
 =?us-ascii?Q?/h6fBmhFDRKMCRM59VgcLvFbAlKdGXG2ElWKSA9g5Y+8VT8+IHMwj1i3g/yK?=
 =?us-ascii?Q?yK6kWEnsYMNSy8PrUWfZ6hxsFN8DpUbpu2RyCqZdX1ukjNI2MF2G4SHeWXnM?=
 =?us-ascii?Q?uuku3m9crAyrOqHUG9Zsu+i5fMU5j1wJXgAnSQl+Zq+TxBGrm8mQRVEr/jov?=
 =?us-ascii?Q?FtpJbIt8Idqbm7D5Qwy/45bQkjjHMkmwJcVX+pv97kU8MOT+5zSYNJjq/ICm?=
 =?us-ascii?Q?cn/T3b0y6fE1avQdHWhjKYeNfhCOpLuJWOVqQZ387tvbeq1vMwMCYaLIEgbT?=
 =?us-ascii?Q?R7s+2nZOvO2UHuMcpj7Hl45Kb3gJTGz3E68WncCLdCO84edRl8lGIQb7Cyi5?=
 =?us-ascii?Q?o9htAutkIB7ZKOX6giDBTSyqcH4EVqYMEbYcV2DY/lP9+5R4ZAylK0rzZI8M?=
 =?us-ascii?Q?feRBphOrD1hU1ufl6v/IajjI3X8yEMZl99buWmy4VleqTmvESRqx1eh1wmyz?=
 =?us-ascii?Q?F+AS0jX0CwjuQIEUHE5ntO8Q7GicEwPcbsotMbKyIu/KlQhaN0Q45F2iYmp7?=
 =?us-ascii?Q?HpP5mzSpKMY25NvODPtc74Q67Kj9gdDfxqF960K+x5Y36lJEjAph2npZMD26?=
 =?us-ascii?Q?7svjA47p6+T6OGVcx2sGGnZd8gnl63zo9FgVwfm5GzkYOilqnXXkNgVjzHpg?=
 =?us-ascii?Q?HirsWtB5qLIUB3gIbT2I7fZe6xCpH6annOMB5QBmhmmjzy3VXLqXLniLyBgi?=
 =?us-ascii?Q?JyiYlyKktHgd1KfqZKJYTbWzEbdmkcq7iLUqfp4DJiKchpc7GoflAhOzTTSb?=
 =?us-ascii?Q?1ql8V+OEgcEYU4qKQbN8YgcZDhj6U/lms0XsaJIilDvzFgnG4v109suWD+5m?=
 =?us-ascii?Q?L61jndLVE8vy8W6tjv30Y+8ai9UaGyGxzwfvhtrU7c7mk0zsAW7rgf7TyHm4?=
 =?us-ascii?Q?4i+sVyhcZBEqhsbWBqJk+DQc6PzPKtKcwoJhaZVaDxCUkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVbeAz+daUsRIjqu2fYrJ4AqNLSKdJY6Ree6SJ8H7VWWphEKVR4mx/cTYqak?=
 =?us-ascii?Q?PvxUUqFsDMeEhsJzCL7kZXyKeCfmV1Qgyu1WGivb4rX0M4o2CXQ15TTV5I5Z?=
 =?us-ascii?Q?RAXDrD5AKQQwyd81tTmg8IkVFnPAsEQ/iWduelr7svmzcbbXQ7Mh1XTjDRNE?=
 =?us-ascii?Q?E/UbHWxxpnclGdVVXtnxGooJ8JIhrOwgV0R3K7fDopqICy9lXCV/SRy3k3bb?=
 =?us-ascii?Q?ndBkfCWQq4Vr8+Fc41+XN15i6qcuxj5EtR5sKNBdoSI1sg2UjvlM7mlL1AKM?=
 =?us-ascii?Q?w9CYmTLsLqV9c+oEc2XgGUKpm6tjdiELrMZXCxkCWgNSgmEDJLnP39obDXpX?=
 =?us-ascii?Q?QYSEF96b4v9sVTRISX6zT+mdvzN024ZIfc7mK4VMFYBw5HGLHqSg68Lzs8aP?=
 =?us-ascii?Q?Y5gOI7DZBsY98NRrx672gtGzam9+JvIWbIR4LPOBpWTMhAya7T6z1kxXPQ3Y?=
 =?us-ascii?Q?BU8uipbrvu/yjNt4nIyDT8OdIvn/0JrMWCBFSvIoZ1Oty4Wd33cs3bPzJcSA?=
 =?us-ascii?Q?dQRrZhYxxkB5tWjRoMYrFLvETOfov9X9mxOWsQYVX8ZVJohOTIoNZQuYZo2X?=
 =?us-ascii?Q?17cewNvJFIV0OtNKB04viEEMONtBGkANcmrO7zJ7+N4ujXyLF6o0RVgGcwhl?=
 =?us-ascii?Q?gUws+FQOsHbKtCYmTEM5G1BqHPbc3dLaiejxtNil8MreNknfHTj1xw0dN+6S?=
 =?us-ascii?Q?ZRqRJHU9qspIvNSA2TDU0p1GK1SIUEAHRgtnGQgZzFNHNieZGoKYOEoWs4Hu?=
 =?us-ascii?Q?BL0uOrCHfPHx7kBJm5Tdz+AHgj1JHYRIQxRqtLpwbd3x3AU6zLSKF/rth4wa?=
 =?us-ascii?Q?2hNxRVirCuW0ZvEiGq5JUU5B6LoW6bzGwsYl1xJJg/Zz9Wktyhcd5x4LYI4f?=
 =?us-ascii?Q?SSC1hOb+UFRDDhwlbk5AoLykNubPgQhByb4BABxs+kg5OcY4pyO+I3QRIupZ?=
 =?us-ascii?Q?yAsWDsncRqnUjzdnAx3NUVFyl8nlMleoUyxQ3TemddV5akvx7pl6oP9U/4NY?=
 =?us-ascii?Q?7zS9gOebhaB1HNJXW4ToA0AyAvSE7udAWMCHMBhRkSMgHYHUuBezY5zDfoGz?=
 =?us-ascii?Q?tl2+NN3+NsSWDbf0XBNBEu/L936rvq3Ngj6yOKfM8uDJSnXBWAMhpYkoJtvB?=
 =?us-ascii?Q?zP1W2HUDrzhwH7VdT+SV5hJPVdPjiIayy1u0jrCZvpOq23sRcgawB9s6Qbcl?=
 =?us-ascii?Q?7nrJc7AICUWmIoubEr8xDWilliYn1wdgBkjkcuHI8sOUdHj2N3UFGc9dEd6p?=
 =?us-ascii?Q?MZ7AXoP8PYh3Wc60ml/3tWQbDNTOI/lNy/4bqE0BvGi7al80FWJrSzenaMbY?=
 =?us-ascii?Q?r+3wzdiBbBFjmV9eQv9CUOzpQ+QQQgkT6PxX4JpbUULEFkW4hVlyY9gr2gYs?=
 =?us-ascii?Q?OeOYUNBjYB+QzD0bmpyncdCA4uuAh7KYs8A2isDVEBWzeg5PQfhqmzMT+Acv?=
 =?us-ascii?Q?owld2TeQhhC8OPCLYiprFYNvlMcnQq9kAxFFMRY+HDfgeRXn+/NRYoc5Vnt9?=
 =?us-ascii?Q?7B79rpKrYM2hjW0U1+2rlmc1ErJg6NJ/eLFIWMrThd0w90R45fAHticdx8wx?=
 =?us-ascii?Q?QQilDFO1DKvT/5lsWKoY/wO6IJfGWXF1T+ObyQcj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a55c037-caef-49fe-d857-08dc60827e09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:07:55.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2uEu79IuQqOqAYHex8HMyf09XxbZdMF/zrWVJOSWUDwCBMbHqVTtEHJfWoGW+wCg/L9dIo5ecJ7TNrWjW+9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10330

From: Robin Gong <yibin.gong@nxp.com>

New sdma script (sdma-6q: v3.6, sdma-7d: v4.6) support i2c at imx8mp and
imx6ull. So add I2C dma support.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    
    - remove ccb_phy from struct sdma_engine
    - add i2c test platform and sdma script version informaiton at commit
      message.

 drivers/dma/imx-sdma.c      | 7 +++++++
 include/linux/dma/imx-dma.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4a4d44ed03c8b..003e1580b9023 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -251,6 +251,8 @@ struct sdma_script_start_addrs {
 	s32 sai_2_mcu_addr;
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
+	s32 i2c_2_mcu_addr;
+	s32 mcu_2_i2c_addr;
 	/* End of v3 array */
 	union { s32 v3_end; s32 mcu_2_zqspi_addr; };
 	/* End of v4 array */
@@ -1082,6 +1084,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
 		break;
+	case IMX_DMATYPE_I2C:
+		per_2_emi = sdma->script_addrs->i2c_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_i2c_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_HDMI:
 		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
 		sdmac->is_ram_script = true;
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index cfec5f946e237..76a8de9ae1517 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -41,6 +41,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SAI,	/* SAI */
 	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
 	IMX_DMATYPE_HDMI,       /* HDMI Audio */
+	IMX_DMATYPE_I2C,	/* I2C */
 };
 
 enum imx_dma_prio {
-- 
2.34.1


