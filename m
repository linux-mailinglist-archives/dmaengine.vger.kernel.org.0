Return-Path: <dmaengine+bounces-1862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFAA8A868F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7A71C217B5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2A1465B9;
	Wed, 17 Apr 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DB4tXPO1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E241465B4;
	Wed, 17 Apr 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365118; cv=fail; b=Bkc7ZaNcFQmOskddpxcwI5wsUBVNHJ0/Nxbfd4NCv98XIqUqB3m/u/FPZpMkCRirfqLnBbWReG5ZjvbPg/1xWz2wLWHWfuIfmp8uq4VkwZuNpgSuUplRd7Z1fyJEMjQW/1UtPL715WrtSAWuSRwpkSavdAtf+UYFNVY7am0nLuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365118; c=relaxed/simple;
	bh=/HTHYwWLjK+OQA5U+i4RkkIYq3L2psKD8oP/dZZ3PDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JiDBgyV4zvdOhJKNxFa3e3MvBpuhmuAhtBghMLl+D0hYnubgd2Uteuge5GaXVN0ypol6TKCNTfav17zGwzPvTqxhFQAGL/fNe8zzmWQ/VGW1o+f3utX98+AeNWD8c0xKhFai85wVoLxEH/GbdnVNji8+TdVQA5K5ggK9xnkpdpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DB4tXPO1; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZB15O6KaZeVZYzgNDV6XZmx7l1VyJG9jIGJMiG3Nixx6+k+mqoPtmYX9m2y0yozBV+Hh+FZerYwh8lOH4VEtHmVFzddyT3mK6HiMxApsTCExXWWPrRM5P4LOYhBuaMjQLV2zWAJFKXpZS/C6/ujHZ7PN7Sl414KLt5W+tYvvArKf2pFs5SeMPBbjhZ3OFBQSsoUmlyPvYBtaZAcnf8LR80Kcu5r7Lnp4fKu0lENlCC0J0HI7LP7S+HWKS7YcrT8u/CPhRTllq8k6eaCnS05Isg3BwsaakD0KMIGbGPmrUspp4SVdMKz7UVwIjj+o8jOhsxeXr+GTMgBL2wxmARCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG42IqRZlci8O2aOXZoBJl8wGQRPDkJbLi1F9zUcv30=;
 b=kOb4RlIZPOJ4qlNYFdgnq3x7DmsKORTxa0EZRRbuPVZ39ltOz0Fai91Gtyy7qnDoMame0L/v+38zzN7C40HB8jupks781COeZJ6WDaEDQLkG/DDVCpkkgUTAODeY9bPCfIZUIsPBeUL6RYHLN7b6jG0ZqGLHbj5pSbYaeHwV9rz62MYNaEmjojFoGzqfUsmOSsP1AqkpYt+O+8YTl5ATmvlHK3fd19KQhXfH+ZdR7V2TD3lj+msEaL7wNetVmj7uAnCqTa3OtF5PzJ97rlSpicfHds/7pNHythzhp1Eoyo/Rno0g8KJRw5+mCDxfnsKxXTtNekEv2Pl2bKtFVlh1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG42IqRZlci8O2aOXZoBJl8wGQRPDkJbLi1F9zUcv30=;
 b=DB4tXPO1uhJzOfJexrDicG/xzFl8FaVBoUBzqibYpgQq8fYhMYNfWk+wH2OGku0nWOkXa5dhsk1ubNU6oDCQxTqAB4l0stUfmAOR4vZT/2eSDj9USCc/3DbfO3mMJmouSu6ucBShzUbsi+jiR9PiXI+Y/Jsu3nfdSxUgnTpiIE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7475.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:45:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:45:13 +0000
Date: Wed, 17 Apr 2024 10:45:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <Zh/gcSXV3ZPpjufh@lizhi-Precision-Tower-5810>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
 <20240417032642.3178669-3-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417032642.3178669-3-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b126ff0-180d-4720-fe97-08dc5eecfd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TSyaEr0BhhIzzYSmPEFH0fhPYBHe2SJf5FgB6BUn8jYFU9eYREYLZbljlIrzgY1j06fJuYwTqjG2YTRhAJqUew9/DjT7hw2/ezGva6L5npgRd05UMnv5HEanLHrJo7Hdv2ZS5LIMpIMNAXJ+2DE9TM/PkAyV+l8G4Rlg5dY8bwzsyYYRYrk1R6a7y3165aQqnWO051Wcx2S9owR21mp1Vo74jonQOK/sdhuOiH76r9oXdYDsOGYWWGRy+lvSt+FKuY6W/HYsXEE1TNY+6Hqxyzmn0GRXWjVpqfrfFFOugfaGtdA3itm9SypMAiESoZUeim4w6r8S0RByYlWuiuct0AIldyM0G4M6tItARXzvvJC4RH3WwY+yd/RS2HYmvGT9K/Hq1+HjEcnMSXXirIQppzsWEX66ooNGLjkzqDF7HKuX35bY09N/CNOzBAnFyrDOWS2bw2p8UgS5WBjrI4UHzqy4ktto6h6sVDP0hF8z+4LWbQtPg+e64n78MhnGZkAdK9UmrdqCN2rUa+F7jyJzPEpRpUrmrPhX2gskey1pl8zNUFMkiWpJY+IM0KUjlF9TJWtOFlUuftd3YkHdfejEjzNVd5EAYt0eIuN+eur+/TT58Se2o2+yU/uqa2muqqYGozcE1khzybe9+BmoStnEXl93P1GWn5zteBU8pIQ0EbG3scg2UpDLvWHK+fB2OBpejBGQUdjklS3FPvSOGSZrJF2R9Bz0UyPkeyCKTKrel8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNRwJmDgJaX81ZLq2e6RyqXKILF1pSUNyWw37W3QELe/9ia24g0lYpSmOjFD?=
 =?us-ascii?Q?fpO2rK6KMhDx16Lj81QVXbCrdhT2SvS3h1LGYZMuJ72ujb+ZUJFXqiIkvN9d?=
 =?us-ascii?Q?+ExS7A9mFBIH1Bf2e71AGvnvXQ+xyAEu9+4i57RdHAWI/+XOITjuacmcm+JZ?=
 =?us-ascii?Q?vVRNwpTaGWK0rS1UvoHQqVkY1dE9sdunW+cULbNwOQM+jG8/O2reG0KQRXQB?=
 =?us-ascii?Q?53k/ikrlcq7day9Ez5pt5r+Nzu4FaUHI1A8PIDRXoXYeXHcUGTkRf1m/5Zk6?=
 =?us-ascii?Q?4ezYR97lqlZ6LtqIKtFOpmIe957zkywibQXl1F3MY/eiXzoKGWObUayPoot9?=
 =?us-ascii?Q?uuHAaDeoI1NnOX9RVRKsK6np96M7EvPWh2nxz5JPPO0gs9nRBFFxzdx2MmWP?=
 =?us-ascii?Q?zWwDONoQMVmkAcbwVbPF6jWNQLkrBBzDQWeei1RE6xqRtrUB8FF/ejc+Wf7C?=
 =?us-ascii?Q?Kpp13Tr79lDE6klXehDmyTRxaY075nyOVtA0nibeLUCNROIA9zKHjJWTaNpe?=
 =?us-ascii?Q?/LNZSPywuW9UWAl/NqkItCgfXWexIdTqAwqC1RgTGKB33N3ID96R6CQVQzl+?=
 =?us-ascii?Q?AqKqWpLt/schxNYcqjvcHoTNdvq1Y1Dv3DyFfqVonxR5Ow7UOt5wxi9Ya98I?=
 =?us-ascii?Q?iF9jRi3+6bRWno3/Ef02TcOaNrj6jcs38Snx8XCOUVX4KIhNgvtjrfJaS9o4?=
 =?us-ascii?Q?oMjspBbAZSW+sa5G5BD2gRoEa2OT6A3/stqOV/eEYvCaDt7ONtjEhjl1vULb?=
 =?us-ascii?Q?/SVRp7upqUlIEvzaDVTM0eElxQW/aZN64KaWq5Zl39jGlXlVQhr92AtUyX2e?=
 =?us-ascii?Q?H7Vp6/GR5ZZpm2MyIzqeNntLea0lWqmnQOWI3o5OAIzZamWfOjC3hIN+NxgD?=
 =?us-ascii?Q?CTNWt3b8KSXSI/gkYh5VYtaAm28qiLe/5pUol7ZxHyaIZj3Tu+ic//JQ3Hr+?=
 =?us-ascii?Q?ZcdKydrzm4hhXfNNwQtGU1VukacQSo2qIEfGQMkFFWTvrkkcefok9yiK3R0g?=
 =?us-ascii?Q?tjrVCouKHu2oio+JkKR/hQnT6MkI2P1dEMi6N0p+mg4jqTlysxSEz/fbrcCY?=
 =?us-ascii?Q?RhZFGSXedK9fZEBRCnX9BUdvmyafDYFAJhBSB2xGLo2WW6DICQ1WHMv19cvs?=
 =?us-ascii?Q?zCQU49wtYYt00n6UijdK5kVpZGvFjpP1ixDgyPuZdgm3GVHasY4Tsahjbaeg?=
 =?us-ascii?Q?Nku1ca4moVhF3vLQtc107ZZlantPB0ubLiqMB7wy8m6TxmnSfU+VCH3CS/wN?=
 =?us-ascii?Q?f6yj78n0/a/vcNSDDC42XmIkStVS+rET7MNuikwfZkte/egvgWVpOJxFK2AH?=
 =?us-ascii?Q?seELJo5n9XQEOUC1mHEVlbAzkM8reivevrBXCmkAkPvQYFJBr8RtN+8R1EE2?=
 =?us-ascii?Q?MJb0pWLTG76GDP4aP2EdcffVNDyItfrPuUPUXwuFF4dA2swS6whkb5J+RWt8?=
 =?us-ascii?Q?T3rcArp+d7Q5wl2NO3UoZRFo7JFhf+VC3dbYY3xcOtCB3qS56TTN51Tzy0eg?=
 =?us-ascii?Q?MjJ+AH6gJoqrnzEeIKtsF0lyuLC+xtJ2cpU26tPaitI1a7XkPSn2RSMON8gF?=
 =?us-ascii?Q?odcBZA6rHmRP9W5pSlycI1hvpVnsKtyUTIrpja0I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b126ff0-180d-4720-fe97-08dc5eecfd70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:45:13.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guv44Fg44lM2bRgWnP3/dL9ZocHWCAIHLfZ/ipkLyNHQ7PvbolkjAd3gjmwP73z0swjcC1jQOBwaKfIoPBe/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7475

On Wed, Apr 17, 2024 at 11:26:42AM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> The compatible string "fsl,imx8qm-adma" is unused. So remove the
> workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

"So remove it safely." 

There are no 'workaround' in bindings doc. after fix it,

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v4:
> 1. adjust the subject to keep consistent with existing patches.
> 
> Changes for v3:
> 1. modify the commit message.
> 2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 825f4715499e..cf97ea86a7a2 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,7 +21,6 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> -          - fsl,imx8qm-adma
>            - fsl,imx8qm-edma
>            - fsl,imx8ulp-edma
>            - fsl,imx93-edma3
> @@ -92,7 +91,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - fsl,imx8qm-adma
>                - fsl,imx8qm-edma
>                - fsl,imx93-edma3
>                - fsl,imx93-edma4
> -- 
> 2.37.1
> 

