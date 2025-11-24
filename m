Return-Path: <dmaengine+bounces-7335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A1C8191B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F7D4E4DA1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120A31A046;
	Mon, 24 Nov 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FhlIiHnH"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75C3191CD;
	Mon, 24 Nov 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001766; cv=fail; b=oTZSlrkHg6/Ix/rak92q8RbcZdBclOc4x8Oxbo7iBajYqmKGpy6G4gLv/inKJS4tOLUdukNtfD/0F3usm/AK1GvkhIluN+U1WX2G3pZ/+jTUQu15KRNJH4DZ4GIQ3IuUabbapqLAseRjODiub9iWNSAjYe0hPD9lKOJsqXH7/Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001766; c=relaxed/simple;
	bh=ERlQXec9G8mggEXwmpLeA5rmttpLQ3TKMx2rtQHUJw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rt2iN8qoDXf+HvZ2suQIVav5U7/SfRNHdZkF3Hu7NQ9WI/pwhBOA2HXVsQbg0xcQrLFSbEJK6Kl8luVCwxuGfJo/qAlEQQM8UM2Q+vusmKVinsKOPbIsLwIOKxO7b97ircoBy2QU04+9zYbagbhUE+JCD1yRHhNECFJrJfrDJY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FhlIiHnH; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl0KpJb7W5QuC6l09Ax4LYgSZV4k/CwbaL96ba9frIGdGXCfS/WC/dMys+UUbGTVVtI3dL+oEqSevbqlXwUBV3xM17v70yGGN/nDjnfb03mBWDnovPXNwvxJcARIc/DI1f2/9r9Lkz28GLisiPrc6GUQtX3jps4Ss9khW4EDS4AlBxW8NrqWsgbtRFmn3sBJfYD4eDXHrYvzx8P5QhqNYc+oc3yN+H+SgHNpLopfrJ/fuWhN1UIg3ZC4wokMdKK0AXs2u1rt/emn6TWkzd83ANYK5BtK8Om1CHvYENVkc3Fff14fPfTQeC1XNY3eMDsMSqI5BgrOmTVMEH/y0cPBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3XfpAJ0hCczQylYLqIV6sjf7DN5hlYZ/nTiv2H7lkk=;
 b=HS2Xkj1deoIWZWhRENwsdRF5G5R96WWqzx28YvVtREAtu1I+li7ChYgmjyDgAkzAWGk3zZeSVxMf60gpjX+2MNvPYDVXvCygu2oWonidDtlQtbnq6mr83rlpZS0c1OfAhxdY80b8fQGVCOPJFzn75PaK1B53pKzbj/nWPV74xtPu26sud81JZrOEsJpvYUUCuz6K0KUOv9sYQzhtLcAtOi4o8atr4c0NxH74PLo6aE3l/aGCWCJKNUp4uw2/Lsif7rwfryicdF9GVFyfPg9+Ab1Zimzn+71RQ7mI8eLiFihqAYPKxserQSGRQuYXQk/qOUTMcAOtm1KijaYwZMZFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3XfpAJ0hCczQylYLqIV6sjf7DN5hlYZ/nTiv2H7lkk=;
 b=FhlIiHnHvJKH7UL3FccWGh4t9i8yYwomj0tE65wANVrkh2fmP0A15ex0G96JkqPIiTDBmn08+ibNfmDrhOaFwbZ2Bhj9cro74QpaH1FtdH2OGQVR7FsrHn7p03XojkMvVFn5HClaOA3VesOYJ5QEKUi5xP6RfNQva8ySpVX8UV65+wMdVvBEf4OaX8I8bFVvEyzDw41S0ErYLsY8O/10OZr9e9bREqBvyCbeOB9dSLHZvDvunLcf6WoUxso4f/UNZ3QGV/7rqHbIF8Td/MRnEOuunV4QNVO5AC2agIIgv48CJ+7WiDLE3l95raIxZzf4/VIjSznBg0mkGK84N4nSMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:29:20 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:29:20 +0000
Date: Mon, 24 Nov 2025 11:29:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dma: fsl-edma: Support source stride for interleaved
 DMA transfers
Message-ID: <aSSH2g8YghKR9Dha@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-7-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-7-dc8f93185464@yoseli.org>
X-ClientProxiedBy: PH8PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::21) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM8PR04MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a863ef-3e11-4538-ebdc-08de2b769ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9wFHeV1aTVO7VuVR00k/eG7vtr4J46Y5xBJBDx1CCoBVArolaUaNdWbM3EE?=
 =?us-ascii?Q?6KLFPgILNRe749+PAdwsU6uRy25y+0tFl3FajC4uMX4absj0/pCNLkQK0Jnw?=
 =?us-ascii?Q?dBvBFNQ5PXgpnUlgtbjB2By49649YmaemfRXzA9zJ5xQIQfwOWT3qEz8ihAQ?=
 =?us-ascii?Q?X4w0LQ0lLtGSe+waHTaY/je3wxh7t7mNsB5nEARffKUaIy33vib2SjJRni78?=
 =?us-ascii?Q?Fo1j34KV2MiB773LWnBm1Ff6LGZ1e7NQWM2pRmgIah8l/bHR6VPUbBYILwOP?=
 =?us-ascii?Q?8DSXZ7togjYePYync+q9wsL7eF947GOeq2Lm3XhSPlnWND7ZLnyEus6bAA7j?=
 =?us-ascii?Q?K+h4oOjzEFd+ZA/F4ZBrCPYnG633vKEBQ7/uUPHD1339un9bVb4ttEThIAlA?=
 =?us-ascii?Q?s+gBahNLF5xHIWADjL3MVJb3CYEsdgf4jw6XgbTulM//Az91hy18MwQgl1WV?=
 =?us-ascii?Q?QUfXYNpig8TtNcA8M7es9iSE/XKRfeg84Q6TQuYT81qQ4a9kQqHd+c1sT6pv?=
 =?us-ascii?Q?FW3lZtNSYUh5WfArHEfJNiisI5q1TXGh3rRuGiNIvZeCR9SiYwPjHH/Yl2OD?=
 =?us-ascii?Q?Bggn2Ml9SrrFkcaYwmjysaA3e9Ruau/xOcEHlshnjLwlnxiP47lRGnsLEdA7?=
 =?us-ascii?Q?POShB4Yv09CQkeZgGZdFUyFSiWpc6eGs4sBET0Gi3b+IiFdxOwpO8uzD+ggH?=
 =?us-ascii?Q?SbIkh7RuoJzC99Ge+wDQS/A3MsfO79sKf69JDBGsTmoO6dQKWBj2OIbQYQ6N?=
 =?us-ascii?Q?8BVvqS3sV5czhUHeezXXE867t27sUheiKyryWBP28EzFi0YeoFr8ubsFPRa3?=
 =?us-ascii?Q?arP2qAmr9Wl1rjSOMsPMC0rKgY4Jhn0nuOPmWRGSCeK/vWP3Gue8uLO+hxW8?=
 =?us-ascii?Q?PTAdX/uUhgKehLkKXjtPNCkrEvu6kIAwiIBCfFrkh+cKp8iKvNiChBudyhmY?=
 =?us-ascii?Q?HaC2wZIdX6CA7qppsV3jjq1QljLVC1ZWdCI1RWWtPE2lLDpXUz0twaYi4AEO?=
 =?us-ascii?Q?sDQEKNuWRdlfT/TqcbrERC6hSYqk1540cZRQWqhPZJG1sd06ULLQmsviKh71?=
 =?us-ascii?Q?Qjplio2FE6R151rMFKhbuaovFNYueg9w2KSGI7PgR2HUlfUMPb9sITImI0QQ?=
 =?us-ascii?Q?yhRhNZwcplleXxh4i+ztzsj2MhJ97dJG0VNpfXl2LMjls92Gknl+rKfKQO2C?=
 =?us-ascii?Q?SlElts8JTDBVeIXtDxMl/G9TErGjEjIHnV80+cDCPsy7sA2ceEZSYDXFkp86?=
 =?us-ascii?Q?6KqLYAHqvS1vFcxJvyoiDeX0AU4UtxUUlcBniXrbvKqmoZaOQpxTWCt85dPD?=
 =?us-ascii?Q?q31p3SoYwKpQmjlPIvX1Is1ezdRdqloMIH3O58Lb/Fk/39XCQ7caLSVStoRt?=
 =?us-ascii?Q?NXJkZAam2NmBO5i1h8mrH5sKDVzFYWxo/C8GQgLtFDDFt8In8Y4v10+Q7qLw?=
 =?us-ascii?Q?OOIVZSQko47tj9fj7HOuk5OCYE2HfSwgoH3H7LSgiGrnx7Y7SqET8lXWdx96?=
 =?us-ascii?Q?gQu7VDT8vo9VHsrdydmuGce17IckxxiyIpgB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+s3pGlIQydJ+KT+t3U8NkhOndMbsjSbK+AwixeCk+Ea0CVwH2fKqf2DbrMq?=
 =?us-ascii?Q?nBqOIwRX/iZhSS6piKIziv5FnI5+lnzzitnSjL56pBNDvCjHtf641YNXhZnl?=
 =?us-ascii?Q?F3mbIpetJmB2O/fV205IPMr+UCAk9A6xF9+4U2yJUeBB6zij6IZYIH2is0ei?=
 =?us-ascii?Q?tWL3pVzlI2iOAUZ3GEOAoVzgplHMTc0Jc3i+9VfbnNtwI6QA0ll11vuiGYGB?=
 =?us-ascii?Q?xPd5I661Lxo7GUp2UviC5V99EaCP+GFczVJUU/S71uIY477f9piDaw45Vi4i?=
 =?us-ascii?Q?EGE6JgSSLE9vLGKqS9SqjVyUIRscoq9aw7FPXuH2Lw/SXB4OGwo8FV4ReKt7?=
 =?us-ascii?Q?YKj13JpW6crBQhewuWEQbASF/5XrisHDySxiMXEFCiYHteGDtESMbuNRzE1F?=
 =?us-ascii?Q?Qr7Al0MsLIqcZmC+i9ej3X2V5z2svXVcWgdDqlDAoseAiZX5RtWlK2idvtJR?=
 =?us-ascii?Q?wQiJyAttzCUN122qR4NvUVUAEDsD83m9U0Ssvs4iO7Uaptx21csntLIZI1N9?=
 =?us-ascii?Q?k1jCg/awM+5lTEtdwW7Kn5vVQN0CsQUp7FPT0JJq6BueSA3qKZFzH7norQyT?=
 =?us-ascii?Q?O46LKKjy6B/SujF4o+g4kzZDFWccHkI4c1Io8WBldHt+qmMNLwvDGNvr3nUd?=
 =?us-ascii?Q?TXo3ecGZ58FXbliJLbQvCXW3IdwRB7MfOkwfSCIdsJWcdJwIT2xo/ipRMBYQ?=
 =?us-ascii?Q?85lMOIJgkElVQCamnBI4xlTh37BvlsTh+MNsQVZzbfkx7PGFvStF9yyKPNlz?=
 =?us-ascii?Q?jwymk+pS/cXa3Oyt4rZU+3iAwmr7N5xkzrGZqiwZYCvCIf6U5XqNITF2psKz?=
 =?us-ascii?Q?LzeCjf3D1zo5MndcrdksEPaqM65ihNoGjuMRI5bvmsgt7EilMRDmdzO+/Nnv?=
 =?us-ascii?Q?mFtN+cZQpFV1/nyI/N8ksmgCM/CA37sZpFLVYSEr5OB89A7BPTH8cHomQwEG?=
 =?us-ascii?Q?Ul1z+/BSYQCIZZliTAG2DW1EZecQVEZ35K+d+Z7R/psHswJP+iaEZaPlR8oG?=
 =?us-ascii?Q?QM4wDL981SQxSU1pIfVbL4uoDj0THs3tWVufCsIfWXh0c/0iGiXEKb6VgvI+?=
 =?us-ascii?Q?7SozMEGSSRprOpIjjXvmBPt/oui17w2HHsFM5+QB7udynDj3YZxxjHR8xUTS?=
 =?us-ascii?Q?CrqaOuz+ll286zhvfi4nenTd3FxhtydAvveDv/nyBs4w1ld5lDPxXIH7cdxN?=
 =?us-ascii?Q?z7MinH4bGu0k2Tg8b20fZAixox3JIUv6jtjI8hYrmwWO67+2w8yTM0SkjmeX?=
 =?us-ascii?Q?DRoC90/3wS9frL9o0i/f5tM1Lni89t5WqelUuCmvPuV4zTVQ+NYk2UU70K0C?=
 =?us-ascii?Q?XAmm+LaqOv2c9SYiIiimR6j+GJ88S38LS+UBgPIKitJIPVN9VCa2kfZbQxc9?=
 =?us-ascii?Q?BT5cTUh8b25MSIhWbL7b9uOBLXkN7CJ4UPTQ6W8L7yHUXffnaZdni+rrKpRI?=
 =?us-ascii?Q?y5IiGV7fO4K7xLgaps+ML/8oWoYNSN1vr0xT2rb62dj1lf8FyUZfLaGsY4cF?=
 =?us-ascii?Q?cFbd0WaDUxtXC1KTc0Tvje75GMAESX8G2jzD/U8anUV+nxVsRs9JO6/7BF3Y?=
 =?us-ascii?Q?H33qyS44OO4xpUVYPlpxlUBrQJ8/FUA9dRvmfIiN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a863ef-3e11-4538-ebdc-08de2b769ee8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:29:20.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHgaPpg0WRWjvZaL4VTcAt1+qE3pLO0x7pmEHW/DZDSAz8Qz4a0J2P6gYuLOVmVfx0dYNPrYhE4LrZE8+tfCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905

On Mon, Nov 24, 2025 at 01:50:28PM +0100, Jean-Michel Hautbois wrote:
> Add support for using src_port_window_size to configure the source
> address stride (SOFF) in DMA transfers. This enables interleaved
> memory access patterns needed for applications like stereo audio
> de-interleaving.
>
> When src_port_window_size is set, the source offset is calculated as:
>   SOFF = src_port_window_size * dst_addr_width
>
> This allows DMA to skip samples in memory while writing consecutive
> samples to the device, enabling efficient stereo-to-mono de-interleaving
> without CPU intervention.

According to defination,

 * @src_port_window_size: The length of the register area in words the data need
 * to be accessed on the device side. It is only used for devices which is using
 * an area instead of a single register to receive the data. Typically the DMA
 * loops in this area in order to transfer the data.

src_port_window_size means the size of the region of continue memory.

It is wrong using src_port_window_size for your case, which want to skip
some memory.

But I think your user case is typical one. Maybe go through
struct dma_interleaved_template.

Frank
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/fsl-edma-common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 40ac6a7d8480b9ed2c6a2bdec59b4fda5fcb6271..e510cab24382fa557a2623465393c852b616fef3 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -647,6 +647,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  			doff = fsl_chan->is_multi_fifo ? 4 : 0;
>  			if (fsl_chan->cfg.dst_port_window_size)
>  				doff = fsl_chan->cfg.dst_addr_width;
> +			if (fsl_chan->cfg.src_port_window_size)
> +				soff = fsl_chan->cfg.src_port_window_size *
> +					fsl_chan->cfg.dst_addr_width;
>  		} else if (direction == DMA_DEV_TO_MEM) {
>  			src_addr = fsl_chan->dma_dev_addr;
>  			dst_addr = dma_buf_next;
> @@ -714,6 +717,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  			dst_addr = fsl_chan->dma_dev_addr;
>  			soff = fsl_chan->cfg.dst_addr_width;
>  			doff = 0;
> +			if (fsl_chan->cfg.src_port_window_size)
> +				soff = fsl_chan->cfg.src_port_window_size *
> +					fsl_chan->cfg.dst_addr_width;
>  		} else if (direction == DMA_DEV_TO_MEM) {
>  			src_addr = fsl_chan->dma_dev_addr;
>  			dst_addr = sg_dma_address(sg);
>
> --
> 2.39.5
>

