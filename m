Return-Path: <dmaengine+bounces-2393-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4190B60B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D180B3C1EE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295DE13AA4E;
	Mon, 17 Jun 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s+PCSRm+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2086.outbound.protection.outlook.com [40.107.8.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59513AA41;
	Mon, 17 Jun 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636565; cv=fail; b=Q8xlxrH/LpN37Ofn0WxiI2DIFAhtcNsFxO6RkH1cKyhA2K1eWO5lJSruF/1D0zjDaBV8Zl0m67dv/9uY6xhbfVUEmYZ8C9dmGERf2HLtV+N+F3trbfZMePqPKaLURaDNwReGuSejGtqJgFiR3dWRjgZ9iIZtiCT6MhCSsP+N+BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636565; c=relaxed/simple;
	bh=U3wXRKnIIXEq/GBv5c3eSLzIoLP4A4hSQqYTHQbrULU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9OmBMMJWRJuNlkGL+17n7OA4MpPslSNTspRn3b0bb5DYnjvKc0kKMdb47aJunAgB6nJXwZd8vpujJTJ86V1uBT+p5G/KZhmoKotP1gSuKel3vYbDp8bM52cnm8XmW/CfbZw0n12D9czggrknAR8E9p+jqUGVJot7y34/oyx9U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s+PCSRm+; arc=fail smtp.client-ip=40.107.8.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+lW/30cFdy8pNdlaFzqWs5JljBZpj30e2eoNk2jAS/3gZHL84VQQm/MRwbgLzbKlJz2rdwXibQ6/6kq4TFIfcycMpHnodDMAS2vj00wIBFkWKHaEfaqfdIhHuVkLC/xeto2S5Qj7vlJf9vKqqYEJzyGsmieXK51SaCioBLlM/SmTuscviP2HOvsHcBRyqR1jGSfJdV1nR5tSyRcvSW5lHrRmS1wFOxb4NkYmMZlf9VmXb5lulUitqsoXg+j7NHBjxN4VaXcLD7nSyLrFsuOxlKCJqAEHBsIgAgqjJ0ctZWDYFjWeh4B8qVceLvijQsYd3r2BOAgbp35g9zDjJXmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoslEez5xytBm29JQCXfCciP5TslbwUt7qXZQT4hO1Y=;
 b=JjiBRi3GdjNWKpo96FtzvS4UHhLxd1X15zYOvxu5iCIYhbivVJqnAAppIi8Q8qRVGCdwYrr3PB/bZ8lLIWEgGTGYuQi+F8xjQD3BQzlqGBc096yrRcrW6D4ZdK+YZ5sbxgpIjMfMYB/0WuVGzDwoXkxRWiJDtCRb0h2+cEP2D9Bnf+6Mwy4dCDlsc7wy3LHty4WOQUdCviSS5iqkjL0yZm5QyIlaayTxxhm+v5YO0Vohc0/nAg5BmmS3qhi2WsGlDViBKugiDnblAx2kUKXUgxxNQK2eMe2usswhKl+R1KKzy8XJOe9DlkALXdf8G/ARZZD4ft/pKwYCYD3ohX+4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoslEez5xytBm29JQCXfCciP5TslbwUt7qXZQT4hO1Y=;
 b=s+PCSRm+80cBnXVpJrK11v4IMTcsYcNDEhP04ofjz0dFO5pYij38zmX1qvWQIAn7gsNm2/yraUMVpayTXgH8lEJRP7a6NLBccqp72tXRCMtSeaqU4BgRIttd9Zf0/vCQmMZDjGCecV0cuqRVlvnZx2r8IvHGZ+Uh1Kni52c6aWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:02:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 15:02:39 +0000
Date: Mon, 17 Jun 2024 11:02:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] arm64: dts: imx8dxl-ss-conn: add gpmi nand
Message-ID: <ZnBQBR84pdozwhSh@lizhi-Precision-Tower-5810>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
 <20240520-gpmi_nand-v2-6-e3017e4c9da5@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-gpmi_nand-v2-6-e3017e4c9da5@nxp.com>
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 7289deba-2005-4d43-5dfa-08dc8ede87f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|52116011|366013|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbHqQAuKapENpiWizmlR4zlwb817IsxIMIH5afLsVhUxJsME+ZRiZAlORxob?=
 =?us-ascii?Q?gJC66WMYiI0+rYX2R60pDB8Jrihngb4iuRhy0MNpzn+YZ/RJ/vV57fef0v8L?=
 =?us-ascii?Q?4B1Sq4N0V2zhuFOvkllDKLEIJTWa8Mdsse4dF1CIZQS0bv8xCCCgHCyL5gWc?=
 =?us-ascii?Q?YRW8EBdlCExsXdJWfKFse9LgxGtL2Pi6O44/ERb0nWKmKUME+kYbrgpZqFIK?=
 =?us-ascii?Q?cXaRn9DAGICXiqhHmgK/vmSheLNCidgX+kgcbSScgeBKG1EWeIQQHQvx8cMa?=
 =?us-ascii?Q?4TYt6DBTj/nugqSIUKfK1gsHx6sOnKLa7zk1t37GNVF16fz8bYyZZ7EwWwG5?=
 =?us-ascii?Q?KntpRGInaUvY6Eig5rHhYlms23pGXIOCeQwxHgcZ6KWqAUWL0OZq7kEuAslr?=
 =?us-ascii?Q?I8uk1mIj516S7Q9d30XprDFXqfua1sSFeaAvZ0fpnoduZ4WxL8CFbvtfUH/e?=
 =?us-ascii?Q?LZtsRm6wc9b197QiSTtFH+Irjx9YBchRkpHypp5x7DPODEYktIDQOTC/jJCQ?=
 =?us-ascii?Q?g4EkyxlnH82x2QDcU+WNZt9XIoGVt0l8BFvv/iByNadw6eW7aG/HFzkBwFAs?=
 =?us-ascii?Q?LR/KN8Sg0uY5/0J56dXfpq813E2gIKWRfNBECVkhjcPI51LmELgqm3XpncBX?=
 =?us-ascii?Q?/FwPF9cZoRdmflsRVNwvSfKyT6Ciomh9B4HqQoMibFypTtOBX1YAmOl+PZ4J?=
 =?us-ascii?Q?0OP7+L2pQPPCT8LL7A02J5K3PMSBVnPtG9Lbc4RKMV1aP7FQPN7+iETdqw/j?=
 =?us-ascii?Q?oMBYuVXbKh/pO6DHFnWrg1UUS3ZxiHkB6VdcVlCtZxMedvZ5T+8le+ag4Dv4?=
 =?us-ascii?Q?4FIk69Ad72qHSt3cvYykIsMYgo+wESYrmJsIpB3ZAKXhrY5Ch2ZzNfwg+Vxf?=
 =?us-ascii?Q?6PrvB+A7aOashjLOty2W48JOMAzvAZZtLV1Z4T4hLpMfZwCoQNcOeYsNkcrk?=
 =?us-ascii?Q?D0iteYKqRl+BFyp8VbT4pjGOyzLTJYtkRh+q+YFWvcs+rOmuuYOX5HaiObop?=
 =?us-ascii?Q?0aOujhruvq00sCZNvSbxsMPoFBxg30eCkIyXDS/wX++cRJv3JN5/YmCxK9t6?=
 =?us-ascii?Q?E4VKD/mbO8X56+bpQg9rwZZFwryuTb5JXw6cfhpabLheO+ovwoSTBPsk1Kec?=
 =?us-ascii?Q?vNtczMb7WmqYxNo9gZs6XInxRzxntEi04Io/O8WK10AR1O/V60jfOQ+mzUD5?=
 =?us-ascii?Q?SVCvKNa7lrhIGqbbwfCXtlkyaVW0vYpfTQqnL9nU8h9b3o+fHcoBvsU/4JdA?=
 =?us-ascii?Q?4b3POutuX/gmpsN6Mp+rbh+mmcm8D9T8hioK0aj5ETAm9LpENaNc40l8n+1E?=
 =?us-ascii?Q?IEPGXyuqCk/aYMyMqdi+gDoXNmTimazI0BD4D5HmrbQ9eZRqj1Mpokm3EZ44?=
 =?us-ascii?Q?7j6pftqCYk2Q3X83KtQeWyaLWBdv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(52116011)(366013)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZEbLn6xMtfXYtlly//Xm1iQNWbFnKMjpTP8wP34XEYFrnccGdfpi0VYk3eG?=
 =?us-ascii?Q?vlZ4nFNCmjmibTK1dpP0rIHPHCSxZO+W881Dmac8I6DIlIQtPEdmw5uNNvBq?=
 =?us-ascii?Q?7CO+DIhTZ5DRX+hUd2m0800Yye6Cqz3WTp5wjBQkA3iq71VZzP//NrPU0emv?=
 =?us-ascii?Q?7SuqoHeqCUK9Q1O/EpeN8de49PdyhdbCmFqAe81u27ozhuA6xx+yX+bnBHI1?=
 =?us-ascii?Q?dL13Ab8tK81BcNZjW8chlJj87dOJyhMLlKQ+VY9UHTFiCgs22dEocirrrK02?=
 =?us-ascii?Q?y0bJ9Ufo8iSlx0dyp5ZArmIj3nyiDnQXKiHxUhhgs2LfpC5WvPyNn1Wk7UZD?=
 =?us-ascii?Q?98C+rUK79y/PzfWbfZDBjgliKnzF64Q+PkrAi7gqisJYWQVbAgqLa6FdaePs?=
 =?us-ascii?Q?ehSQtQ6uah8334gre13nRLi3045u1lZJ10mqAGD8aixkEk6lt54jiKyqzJmD?=
 =?us-ascii?Q?n5ZaGksZvvpijGkavF9KFcbdkukUkOAokCdCoE4cNsI9E5KVCi5pe+MCOSkk?=
 =?us-ascii?Q?rXg5ONzoEx/CH4pNOj0U0eoUfjgv/dIIpl6HheNJqdMWBQsfMQqrJ3i/BQTk?=
 =?us-ascii?Q?R6ZOcJN+Ib7lHF0X8sdn87lmPIGkwoAPAWvJC5E/dRnZxqFGE0gYebWVPR05?=
 =?us-ascii?Q?y7XigfpXAOTWaydKQ0CmP9DeqmonlDNkUF7+ozBoka00w2igcKemjFUETIoG?=
 =?us-ascii?Q?LRSGa4y3Ypn/Xic1OijBY+quTav0B97IxYUjKIsvLhxwo/IjVk25JhDYdNED?=
 =?us-ascii?Q?sKiTei2oyrrYOxRxSuSqBLzAAnfNUoEV7ciMOYkwO1CYLD151ZDW28osKIAM?=
 =?us-ascii?Q?9073XkpVDltsnke7fCLQ2A2yAli901C6M8I3IxReGfxVqZnQMELeHygJYKCc?=
 =?us-ascii?Q?OJUv/FS9FAA5KXSwYerqhXud1s69bkKv53WT7jwBCdjfj7n/IeOc9nxk7cWH?=
 =?us-ascii?Q?x0E2K+sK1fyKnaFoV8jvcDdmHIm51mc331DZhds69ygVxEVfVPARi5AgTNQC?=
 =?us-ascii?Q?i5BWjETgzZKPdovIhrKtzjA0rP0abDz3lz+T5p5hLO7BzsQa3m44HLySZjQx?=
 =?us-ascii?Q?6bCSWX5Ihu3dwNf6dlIyNF0U9n543oPbZW7nH6ryI48S1T/1tQDeA6ZFWv+J?=
 =?us-ascii?Q?3XHqK8U66DKQWxJJ1Wl4mVhr/sSPsF9xJXLfXB3GV/SrSSDcjn472Y8eMaPs?=
 =?us-ascii?Q?wSVnizn0H9RoYccIw4qVCHUN+LtO+lbjs1pnMR9CVx1PYQD2vtKcTXR6IA7g?=
 =?us-ascii?Q?pV/RIvBgINl2sYKNpmZWHe7KkaoiLXtmx2ITVRKP1beLMCAhWy56kC2/gHkA?=
 =?us-ascii?Q?2qGlSg3f4QZPhsxMC8gwxsIfROzC/IcA5rjggkPp+btHLvG217cfe1FXzpQR?=
 =?us-ascii?Q?mjT7JaKvyIRpL4bHoN4G/i8odDyC3TBnZQ8dCAOp8FDrAaaouIxmDMGkTHVW?=
 =?us-ascii?Q?og6/8Di2BF9x9hI9EgxdU/vzOLTNy8E0cVcrlIvIl6jkIiHpTMCQ3cxpM16X?=
 =?us-ascii?Q?UojXx3vA7LEkTp8l7Pq1sFl7OMjulUZiPDsC8zBfEscbun3B7xl5yeNzlSbQ?=
 =?us-ascii?Q?awMvQqQ6kpFVIKCwQhLgezQHSwS1g9q9W/UWbiWL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7289deba-2005-4d43-5dfa-08dc8ede87f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:02:39.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rruAQNmHmjq8dyJ7PZd6lCJUDHv4KHLLuYPAk/VR+AK7H+p7CGsLW80AlszL0+x1C41o2dvPwvmQg7vV+3H1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

On Mon, May 20, 2024 at 12:09:17PM -0400, Frank Li wrote:
> Update gpmi nand and dma_apbh interrupt number for imx8dxl.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Shawn:
    Driver and binding part already picked. Can you take care dts part?

Frank

> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> index 6d13e4fafb761..1e02b04494e94 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> @@ -108,6 +108,13 @@ usb2_2_lpcg: clock-controller@5b280000 {
>  
>  };
>  
> +&dma_apbh {
> +	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &enet0_lpcg {
>  	clocks = <&conn_enet0_root_clk>,
>  		 <&conn_enet0_root_clk>,
> @@ -127,6 +134,10 @@ &fec1 {
>  	assigned-clock-rates = <125000000>;
>  };
>  
> +&gpmi {
> +	interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &usdhc1 {
>  	compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
>  	interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> 
> -- 
> 2.34.1
> 

