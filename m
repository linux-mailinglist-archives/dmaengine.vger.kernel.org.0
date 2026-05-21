Return-Path: <dmaengine+bounces-10697-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MTTB+0/D2pNIQYAu9opvQ
	(envelope-from <dmaengine+bounces-10697-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:25:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617D5AA2D1
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC203023A5A
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781533B6F9;
	Thu, 21 May 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMApA+MK"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC41F7916;
	Thu, 21 May 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380252; cv=fail; b=ZJO/l/Udu8SFYlNebr9TyualEPf0JF/EGPmVQnPbGPzVoRoI2G3PHbGIHpGgnsSzVbAH2QWM4+hF/7ni3km9S1Wq1U1ZZU0vqykfgkqYFZuZQYWFrAn3U7x55LKxEAQGu7nPvQnadnLNXg0wZB20xOq2VosP19pLKpjCTOGYaL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380252; c=relaxed/simple;
	bh=yvQJjOtoUgBP0pJc5DWJeVsmmykNFxv7kHqhi1mkxUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crIxBmPQsC6w4HvOH77X2nZxCV20CKH8XVOk6m5L0d7towdybpXNcpsPjZRwbr4lL1ckctegmBlgTkgkEePaCJGcgxoA3sggIq/A9jxhUWt8HJupONr5gOAi1CTpFdbDxxQoUOy2XK/GzlhRJ1dXD3bs+waWPauIfBGQ0gUb0kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lMApA+MK; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxof7CwPv8SRYwQLUEidHaGH6wWCyAir5ebH2Z96Jf+Di7G7Da8omU9KgDUWhiyz+iM6hiSoWjvu6v9K+bT2DJi27qxYAQ7FvAsP0EoC/4ZMkoWxklPyFOHjrRoxaO5u15cdwirRPagwlZVYp1HUFqMU65odrxHMGHo9tNRuaB7HRf5yRY5wad9dQRyffK549zGntOtNS8w7dyLeHbVWvMIVQnLqM2ugMv6Gcfpn6Ecytff2KuDfgEY8ulFxHOk1HyIrkWHWF5NyXCB7kgdij0CVFKXSl6D8qxiTzaPXA1yFDOD7PH/C4w+P6DisgPchwgnL9DFbOHkDxj5n0K4Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WiDR8x0J5guBQVIjyXCr9VvvinBvk39KQtzk/No6q0=;
 b=AfTR9oJHzJx6Bz+HOoddHDh5eICdtrrirNuTdtXT13Qie8immgnP950mZPhu90A9PZdjguC+FmLwEs6h5xn6ueGmPaKAR1xa2kTIZqPB7ryKuceuaevKaLEwj8dlCo5Ivns4WlWfgdj9q4y/6LcOWAoemVAkJlj7DDKWZZr7zSpvuWsOUiIF/2si9Om0KawXnOdYiI4XMvvkv9tLpILe16ldrr5RBFobEAeqkm7sY4DKBFvXgCg9xS9E90KmemooEPY8pnVfF3Q+FI8pwfY1E69PpjiZCCMInpce3PvF6z99nvWIs3DdmHeNonlu1Vek2znw0+HkMAj362f9NPRR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WiDR8x0J5guBQVIjyXCr9VvvinBvk39KQtzk/No6q0=;
 b=lMApA+MK/SAaWMyggZVB0NhoHmI2cDG82h1gUg2xLdgC6ne57yXeQY5ym1sSPPocZCg6QAZ5TqdKe/nCPsUO23hiD2NG4miCf18C+jvWGksEUxsBJGo2tz5xNpetV0Lxk77mF2sSS0UdM8p7X9xn1mIw98Ky4ij2BF0e1+aPtblcRGNWqVvVhoG7DIH6bSDAKdFiGuetZmFu4ge+U0KjZSScFppT4JE1j4zJz/rGyschTBrXFaV6TG+xGUfwrh6MjJx2zjtQc2BDi0zjJzbC7Msj1u6cklIeu4lfQVf9vjSxvWaesOsY1A1AvSGOABFD5Smkfvj3jucfUyyV6jjXYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:17:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:17:28 +0000
Date: Thu, 21 May 2026 12:17:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: dw-edma-pcie: Add register offset match
 flag
Message-ID: <ag8wETTj4HhAxGYX@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-10-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:510:339::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ef60da-ba11-4908-c316-08deb754741f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|11063799006|4143699003|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	JSbpUdQpmBINFpAO1vdw/LJuJc1Vr8U9p7npXci4+1ndQ7D16GUhwHWS4ouiZ3sWKJ4+2eLhonygVG0+vgxR5apvJ8+aEfbY9HwExcFXSl4vmcSrjyROkruvpKNpnRdI4KDD7KHjMwDGevlI77kX/OuJ78zOxslAVQisaoK8+mQ4EjJrN8ggJQwVnABHXKfglMCKqkF3/y30RpzqNgQNGVJHxoAZqnYxcBM16BBm1Opu+a6j8uNRJwrWTsbH6nmaDOKQt2KjMJPcXtghVGNQvDToTtwmVs8fQ+7h3KGfwDxUkunY25QeIKPsRSGp7yBiHTDpRvCqO9unquoV5p8tYsbsXXhkRN7WUEOpkum3ATPGM35DlU2uTF7l/2tQi172QbFeIt29z6mAqQBuGv6Die+jThcoTqHNly4LXqn/rc2U3t+lrjIhGuNsHOm//vohyAt7w87LLPzC8PgGtgtfnWUHMtw0e21GDRE7SZ0uI47y3UMKQ3juUCt1tUBOl+Jb/nEKneuGg/smo+yW4YKGeNzJXK6PshOy0t9KKsZ3qbLw3ZC702dyPONMKwmlF89kSj4jSLVSmPbzIC5KgSbRJ+bi3pCSvM7/RjO+OoWNZBAmklDQQmA9I9iXgokE7t8V2srZ1WkePGFK9AlRdp79QtUwHXooIUziiuHh9xWzDpdtdIoTygJmSGP1c5NlknI0ZS4Rl+ytO49Rgfm4GWYxzM553+A37sWYYTFFQSkWxl/S8uHSW63htC/usS2BBkUr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2sG9F9vC8aFrePZBr+nKN3cI5xdVR2ITXO4EcNbJUbo8R6Bx23N4PL5QuSWJ?=
 =?us-ascii?Q?E5nzWtg70UbFGEsS8GQ1UipGQ5coYRjCR1ouhJTICVLNqK0xWqVe5IgzLrUj?=
 =?us-ascii?Q?sXte5d5Br3nwPd9TRfMRGo3vRwzfPoQL4/Y4A3Kt6by+wwH2L4SGt946ASPm?=
 =?us-ascii?Q?yoUkUuZhQXsYPU7B4LOSp2WkrnYKfsITkOyCbJIaeNkNR6LqD/0u6yirogIJ?=
 =?us-ascii?Q?IsxfeOpJYgvLLxMLBQH/vgpp5Hbr15u7+k/knd7oszuoJwgBpf28IaiaQ+Tw?=
 =?us-ascii?Q?sz12DRZmtUVkHfhhbvCf2xfRmejgi4hvc+ElKJDgMZc2GVRumEED71fW47DD?=
 =?us-ascii?Q?0xv4OGfWkMonpGYAjlUilLSwkabqOR6C7Dg+rap9eMD2HvPsQgQmzM18L0xo?=
 =?us-ascii?Q?qhFdyHQcMObg1OhhGkoknme/elNyHq7u9dzR8dod1KUS2DShWPrfQOXTgB47?=
 =?us-ascii?Q?ln1Iig4WQfNZS81aOcjWGcLr3DeVG9UGdiMPMY2X8fYe8KjYLVEJApbRKsj5?=
 =?us-ascii?Q?fZFAaDpyPvkVDT8F0vEJkMKH65e6SMep88ikuqK8LiVBwlokFtwbumQOFipx?=
 =?us-ascii?Q?vkv51rnSIxc8meAJQZImSCsbFYdYRddB51SBXkBpIFZB2PvcSByA0ALdn4qW?=
 =?us-ascii?Q?AfytTakJxGsGP/Lcd8cn0KtHxyOo2lZYQ6QdVAZwB60aO4yeWCP7qLJFfoZH?=
 =?us-ascii?Q?MU/VKm4qm0/L3OLSiEVBCRP7hLqhMIQz88VOC9vkHTq26oL490Ve6Cxo9Sw8?=
 =?us-ascii?Q?vMpithxvrU6HBMYPCoKpi14aBPQMKU5WUIHFx9f9fBKLNEUzPRe4p+8QOkiS?=
 =?us-ascii?Q?/y9oZwPPQA5FnUVaUR4xD9u1OtzBCL7PFxiHUuVEJ/AnrjQ69DOJB0F76BNb?=
 =?us-ascii?Q?Ni+n4MLnL/WCTagfh5pXpiLAeS8rRFPXve58MixK+APBgx1khpiWQ2495VVE?=
 =?us-ascii?Q?Aae5A7jQP/vjAF9B0biSopk4CdGd+v4AsAY7eFrMmWMnPybjpLG3lrRpjnDw?=
 =?us-ascii?Q?OPZEPsGDbp+vn1hC5cAVXnjJC93KR/vFKSuTmiA1qdMA2GRdyq9LNO6fkXhE?=
 =?us-ascii?Q?nbZccQZnO88m0xR0fH5uQoKK9egRcerRqUFIWU0Dc8OnKjVO+aMKuPnHU/Qo?=
 =?us-ascii?Q?Q9Ja0t3bDV5PiMnMG2i6h96CQlX8fGZnUeqQd6/3dyw+MxK5wYqxtEqrPyFr?=
 =?us-ascii?Q?b3u2ngWvuVbUjOAqHrKTgohH9O3zRQCtvAP1OYD1GytrrRBkkvVRdV+z5uiR?=
 =?us-ascii?Q?qmLSBl5O2cHuyOS4CxebVuqfPXAYkgnK08U2HfQ41+4qLkLfwyQ2y8k00j1f?=
 =?us-ascii?Q?MBjnHf1CimPnI3CGfA0uEm8K61v0bwhtGhzrG+W8O+WZcD0zik1GoYY4Q8ql?=
 =?us-ascii?Q?djwUOq2Bo34EzXAl2miDkYphciKPeSzirCouJax4oiBhYA9OuldOnfQs7/WT?=
 =?us-ascii?Q?S0wZ8Oum5XMzdcI4z1vT75R6J3fxzkIMF+bZtgJKybAJmrb5zNqXnZcETRkN?=
 =?us-ascii?Q?JGA77bZjaZ0qfxOry+0LXtHyBji4GJwfa8wcRGqFYMy/KFl/PLa6QatUsmS/?=
 =?us-ascii?Q?czVGvRhAC5Tq5MPP7turJS6PD+9XiJq03liFcpifw8lOV+FuxpYzF1UnXim4?=
 =?us-ascii?Q?6atk0CHHtK8s1RXQdSnowGOV1GC8WBX6q43/v00ePbBuYSgO2DkMWHF/+0SB?=
 =?us-ascii?Q?ZNVHMbJtLn4I5/akTC2iAvBobKx/I07vB4fQICuU2UEiCtolR5GSSEWBvI4t?=
 =?us-ascii?Q?x6VFa0GeCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ef60da-ba11-4908-c316-08deb754741f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:17:28.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt01HJeU1EbkmJVq3wi4ZibG8qzz4CJUcn4eoP0QtEOhRgn8InZ/6KkyBv87Y0OVaJZaE7P9+P7Emmlf58TMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10697-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8617D5AA2D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:12PM +0900, Koichiro Den wrote:
> Add a match-data flag for devices whose DMA register block starts at an
> offset inside the mapped BAR. Existing Synopsys EDDA and AMD/Xilinx MDB
> matches keep using the BAR mapping base directly.
>
> No functional change intended.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 651269708cc5..6b375a58c550 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
>
>  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
>  #define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
> +#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(2)
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
>  	/* eDMA registers location */
> @@ -450,6 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;
> +	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
> +		chip->reg_base += dma_data->rg.off;

suppose default rg.off is 0, so needn't flag DW_EDMA_PCIE_F_REG_OFFSET.

Frank

>
>  	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> --
> 2.51.0
>

