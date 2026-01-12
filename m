Return-Path: <dmaengine+bounces-8226-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9EFD15607
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF84A3069205
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EE30F54A;
	Mon, 12 Jan 2026 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eFvCJmNH"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA62E6CC5
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251717; cv=fail; b=WdVUGw9VPuOx4pr6e8dzvnqMNcZmR+oU5ya5OTrTe4vjLxriqnHaGT+8CVyHeQAZ9HQJ4Rd71FcD4sbv3HC9skW+5fUDbizC84y5NdkI54MV4+F25tG2ZVnmbKFY90lawgKxZGJ6P22f/LcZOpeGyFwR0nzianE969E/tTyjdvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251717; c=relaxed/simple;
	bh=+Ckdb28W9FT/ljxY28QbaP3i4oUhVGFUF7AgGy9lIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RwQ5bHurM6b6obVIoUTb86+IEpr1NYN5DpEnScjFja4Doa86SM9CMBD7em686j2ZVSY6ge8ETW/zCzgT1LJfick8d6+3QZzfUkURs5EaGoiqdfRYmgczUMS9votC9pEPBG+NtazRBk3KWZ9DzJt7RogUPYcza3q57jpAQNr4bpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eFvCJmNH; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBv4+Dl0cr+Wl9Kc8ijveu7koTe3LZ695i3W9pfAb4RvCq4qb2MK1xwqfhOy1d8RHctgvDHT4M8n/tEU/ZKWKmNJKZSMggLS3iWvUtwlBvszfviRRA9YgiKZ0zEV7D7zta8jFVMCDUNqjetEa1cVbOJXOOvLx9sKQ3UXLwpY/KCu8HspaDbPEbX7pF8RXOtdPMcYTjbyn7jONiDevp84Of9C3FX10geZVWKZ0EZnUj1ChnNrH8doKLvMhhaGQIxRoULSaQ20NJyw8XvnU4iTn2hyEQNPJ4E4g76J4klIwabid+PgWbBGwJNF1uo/L1lUBz8IO9rs7Cu+onX2htFKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nYdwmOhBn3c83TEHnr848z8fo6S7GCOfl64pjuj3XA=;
 b=H3eVpdHzkzGzIzerDx0HP1xFJhYl/OxoV9aTjwpL1HhEWiZV+tlMCr5G+BUUFrBz7nAYG/e6PQUh6nrXR0bSliDvmr4KaJeSQqfGjA2zZmJFwx3ChBILIyZGZYubAPQikYOp4Y0K4DP7FEs1+a9yFSVhpHtdI0MtDDUPz8JiuSbU2Ivw4YESlWYH8PTFmMdDtecT9+wMcnZ3+W4EcVsEAngINmSII3pTPwBUmptfTojORFh8H7hFM7nzmle0oYCrVMHlw3KLOqV9K41qCigwprPd1B5Ge6bJt84AGUflBUan4mfGTlZGbI10SI2K5GY3w8UMWAxsVLUBStXIwbunmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nYdwmOhBn3c83TEHnr848z8fo6S7GCOfl64pjuj3XA=;
 b=eFvCJmNH5sGmvfcrdwAyL6vJhXQiigf5PqpZ3ZApocHwscwQzp6GL4oBLmB2K+bHXDprmiXfDuerYeh6WlxHhJu1+cp3SzEvoj3/2riMk2NpBy3b5gPB5IBq712xDI4kDTfduZT6eA/fyspPODM/0G1EijiJ3nhp+N5HkcvtJeryuf2c6/FD5gowk1RiabQP6lFcGLcbunuxn+G5G9zdAu/GqXLLvX20Dc0XvVLhEN+lY7i4o7z4N2m/z6jNfdE6a0z/XvtFHEwEfqmpgdGvVWE+dJ0x0hxiLO05BCymGtqOrPDNDMvsIS9oQhmg9OcyoswwHGl5LhohiKQTUg1Qpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:01:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 21:01:51 +0000
Date: Mon, 12 Jan 2026 16:01:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aWVhOZnWUhIBbI+I@lizhi-Precision-Tower-5810>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-4-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112184017.2601-4-logang@deltatee.com>
X-ClientProxiedBy: PH8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::19) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b18bb1-d93c-4d7b-30ed-08de521dcf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?95VM5pXv01/E321/xXYBmULcXN/tnmBSgL426fVncY1p+QkCQLKe+op4/BOr?=
 =?us-ascii?Q?jlX48Aw6hUK65DidN2m6Kb1yfutIKHiSp6k2G8ubt/6TDbwWbEIhBVZ0t/WK?=
 =?us-ascii?Q?SUqUW8JFJxSxPjOzKtIukG0tG1DCqEA7fgEEx93+cuud56hEgY6NT6ZI2Toz?=
 =?us-ascii?Q?yWFxcDVg6DaVzRa4RJI60io4emmiFQ0GAM2WcNw8nVAaauBz/qvfCPa0j3mK?=
 =?us-ascii?Q?mjVLe6BP1aUcXJZItvTc3ohpmUlpKL8uZN5UPqR9iJPLS6bQsd4lOTtfjyh9?=
 =?us-ascii?Q?KXYIDRtGEwWQLgDD+U3nskP+euTe5d9yDnSJxLlMWaohOf7Zwe5ilSzmjNaz?=
 =?us-ascii?Q?WhAuVaudCPAXaNUzPfmN1/cqCpzQovqJ56Cl+P0/sVc2XA8NXW+/ccI0NXyh?=
 =?us-ascii?Q?yZbKRTt5QuclqGux66bp8yGvm0enJTVHDgajRnjOzE+dVfLT3svlKPE2mjB9?=
 =?us-ascii?Q?glzMtqxHpUCdAg4QQ5CKUgszvtm92PqZBuwjSf3nuqCpGep7jBqbtkpqKM94?=
 =?us-ascii?Q?QQ3IWL2Ri+izETJzRLoL05chqn/smXeldi6hCkcDpREwP+uzQ4ybTHVpbYVx?=
 =?us-ascii?Q?o41uya+MtsRiZIvR9Rk48pwOpbOxMff7JTxlMhbtTxwjD0JlrKQAJOWkaq6c?=
 =?us-ascii?Q?nSafTrbTbGpp08Uiehj18YnWRzf46NMqarLSMNnP8mTcKs5Oq8E8YbWAQCQT?=
 =?us-ascii?Q?XlLYh/ev12beKfSsBe3tgvjH3AYso9P7zpR0kPfz6bxlT3a8ymoMmWjL+nX/?=
 =?us-ascii?Q?SJXPZQhnGwJgLAOf696D8999rOvGAqWICoRBa5iCTZgz24IxaZF8TITuq0rz?=
 =?us-ascii?Q?iW7hTcRz7ov9mwCtYt9bEuNSRy3EoVuZK26/rmrsIXkR0V97ugzLppAOitsy?=
 =?us-ascii?Q?FxXZ80rMryFkF981qVmzxf2EQ/gtq31u8r3Mj0eMAVDEy7AZKTvJ5B7k+YE5?=
 =?us-ascii?Q?dmikVyXnyk2duCHk2GtxqOSpaunjoK12qjb+vQT4f8pVKchLGL66K+5X2Zwj?=
 =?us-ascii?Q?HRuC+q0NIE8Tn9Y9zrYbysUeaTKLApEqx6QT8c1fEXcyqg7ggpbktARo7z24?=
 =?us-ascii?Q?WCwb7CxnDXh2MNfJc3HzVaqf/glV4NG/l6VSBbAGPDrxqYGkeAgwU2qYImBP?=
 =?us-ascii?Q?6X69GNIDvy7PpzotKzmMl2XdJzjYynP2aJe7neM2rovEQ86Q9LNfiXeB33sx?=
 =?us-ascii?Q?azkRfiFqal9PubQ9Fn6eW40x3p2+9ILdgbw+ESUsvg15TELX9KfE7+b9TW+X?=
 =?us-ascii?Q?tARpWWcWcbELxFoXD+DbE2K2+KHJCZgPR2hR189xbx0OV6s0K3VGuA4GB67U?=
 =?us-ascii?Q?YN5O17Kyyd5okDREft+z5UFZ3ByWy1xoDJHuvcXVnH7diwOVnNJjBsUSZLTC?=
 =?us-ascii?Q?R2uuVN0UvnkdO+Mw9Quiq/JSoDj4uRgoVTeedPWBmV2jUqNBrQKQ4wtiw8TL?=
 =?us-ascii?Q?I+toTlCBThFUCPP24abtQRaLpHAYIL+k1apzGRXsZc5YPsU8gkIidTXd1IQD?=
 =?us-ascii?Q?5j95QEhyktAw4Wt01yPYusDN5B2k1ir6c8O9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5te0Yk9DjJMVQ8O2ZFMmvyhyRVy1L+0dQomI7UPU1z2vHQnrzEKc+roQbKIH?=
 =?us-ascii?Q?dxiW01xhA6j2fBpRp7q9aZmTQgk3z7knGdaBMKl1OcSwanq/1PCUyR/vAVkf?=
 =?us-ascii?Q?WRxmhx2XXs1zcsStE0dFC3XSdGMjTUVomL7s4Nz2UG7heVhoB9nmvuJVInhg?=
 =?us-ascii?Q?TDU7HcX7sOl7uT47Rtfw8qOCjv668B/hhyD8RB9xAlsDLL7rqHw8vhsqZzkp?=
 =?us-ascii?Q?VaoPZmJplJUU8oZcUolPGkKHaDqg129en/fypi0xWIwbfjgyYhvw9SzdsgxL?=
 =?us-ascii?Q?s61S5zVnJaRN9tE6K/XG1KRkTTH8nBk7LbJ2b/u7aG34SrtDCRqKB5IeCU+c?=
 =?us-ascii?Q?cgb5iIzxkwYjcPxfqWIISxW0TiT/metRjHLcRIzBHUGASOic4InOrwrApoU4?=
 =?us-ascii?Q?1UuMNJuoaBCxaDIjVjflKUmnzuWkkvjTZdclD5NovQMjbWsQA1AdO/lAMU2n?=
 =?us-ascii?Q?Rvk3VJ6yq0ptO8EKp2znxptph3ZdQq3WyU9hNo+uWVrlK8LLc8VwM8Nzeufp?=
 =?us-ascii?Q?Y1DjwmGaI/FoUF9KJdLqBvEuLDllWOwz0mdaeQ/ZIQavne+BQEeGL31Z2Lg2?=
 =?us-ascii?Q?TkZeBb4U2OUqq3YZ1dD3P0yLHi7GnST0UyfLLzKmShYi7DI0+WNjBNG3591h?=
 =?us-ascii?Q?oUJTCPcoeDvL01RO3XwUVjY+q5HCEHvNys03io8bKhJPEUrrcsB+2QPQFT5o?=
 =?us-ascii?Q?7PdQOKJMsEeEAvwsvGhmMHiEN108ze2QahRRHOayQVjn19wblxOcMX2HtfIW?=
 =?us-ascii?Q?JootRwWq5UEKDud0PIUHdD1PsUJJUrPuBYQLnz2bswnYLq/PtSGtq+dQYpZY?=
 =?us-ascii?Q?s/YYMlpcRxMOj2bNDNu81Vy1gduozOrOfQQ5EkYm4i1Ts7j1OY0GOnnEdqKQ?=
 =?us-ascii?Q?txc7njLdGuJjV1aZzG+GTJ4JZMPAY4wU+pgCcrlvON7WSneFKYbMrsmekMs7?=
 =?us-ascii?Q?f311VSY5lBlNjaYn3iYMqLNDX+YhhC7+PwrUiir66LvT3BCeVr1SCn1K+og5?=
 =?us-ascii?Q?6EXv/cKUJbB9/0pevNnR2E+tvbC4/YWGdFnfp1PtZPe/nCdJN2nDiHH1VjNA?=
 =?us-ascii?Q?i/Kgn1HeHbUZJTXr4bqXd6QsCvwRRrDM+xjdW3n1BThk6DaMf+6rHxvPdapo?=
 =?us-ascii?Q?ORYgFYf8tnPusQKRe4xW5OVwf8PHCUXKkd4ZdrFBU/ID4IAK03E944SpKM1b?=
 =?us-ascii?Q?zxt916t4KfYGlmh/BTTM7fZMO10DsJ2D8pdkylcCMsgC4jq7GMaAQXKU7v97?=
 =?us-ascii?Q?etpwTHh8QY7h5Xuj/AlWN/5sjeyn9fS2JaaFx/q+eVsWa/9tLTNoKjAaXgIQ?=
 =?us-ascii?Q?RowwNfRwjssbYy8EJr1ZGWboPN8WMVTiN88LBerE8g57IKTo/t9AyvlOF258?=
 =?us-ascii?Q?/LGR3nqlDQQjNvIUZA80yMiTST+O6AuU1QETzAJRlvSpQ+uysozsnjQ5QZFz?=
 =?us-ascii?Q?mnTF59oeA0SmmJFJAabo1+vFJTNxbn74VvuYtw7bKfzX2PuKXn8o/DhsC5vG?=
 =?us-ascii?Q?b6/l/rtlIS/LjJXhR7GcamPWG9IcT8EXxd4/2cx66fGH7Wc27T/cN3aNAsfs?=
 =?us-ascii?Q?V5UxZcGrJDuBFf8Ec9kzewfMy0yzmUt/JzL/WFWlqmFpYyIapznQQ9iQRjOI?=
 =?us-ascii?Q?WtELJgpzoyeWFMB1Z0Lmgp6Xfkx62ZcYGxz0mJN+LA1/ZnhIcLjfEX9rVNl+?=
 =?us-ascii?Q?CWC0aY2lObUyg4ysqzS1wVizrgqP02fuf6evTvYDQmlr9QM3qf2veN/mvLr0?=
 =?us-ascii?Q?ltmO+LGQkw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b18bb1-d93c-4d7b-30ed-08de521dcf09
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:01:51.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J692zBV8K83BQQkSsBsh/Ntipwp7Etk4C4s3uUtxDw6rWswYgxLHaMV1/OWOB8FEmRabnSsGtZ1oInoJJaelPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

On Mon, Jan 12, 2026 at 11:40:17AM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> On prep, a spin lock is taken and the next entry in the circular buffer
> is filled. On submit, the spin lock just needs to be released as the
> requests are already pending.
>
> When switchtec_dma_issue_pending() is called, the sq_tail register
> is written to indicate there are new jobs for the dma engine to start
> on.
>
> Pause and resume operations are implemented by writing to a control
> register.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 231 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 78cfeffed9a1..3b75a20e83c9 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -32,6 +32,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_REG_SE_BUF_CNT	0x98
>  #define SWITCHTEC_REG_SE_BUF_BASE	0x9a
>
> +#define SWITCHTEC_DESC_MAX_SIZE		0x100000
> +
>  #define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
>  #define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
>  #define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> @@ -41,6 +43,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
>  #define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
>
> +#define SWITCHTEC_INVALID_HFID 0xffff
> +
>  #define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
>  #define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
>
> @@ -204,6 +208,11 @@ struct switchtec_dma_hw_se_desc {
>  	__le16 sfid;
>  };
>
> +#define SWITCHTEC_SE_DFM		BIT(5)
> +#define SWITCHTEC_SE_LIOF		BIT(6)
> +#define SWITCHTEC_SE_BRR		BIT(7)
> +#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
> +
>  #define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
>  #define SWITCHTEC_CE_SC_UR		BIT(1)
>  #define SWITCHTEC_CE_SC_CA		BIT(2)
> @@ -603,6 +612,220 @@ static void switchtec_dma_synchronize(struct dma_chan *chan)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
>
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> +			size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(c, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_desc *desc;
> +	int head, tail;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +
> +	if (!swdma_chan->ring_active)
> +		goto err_unlock;
> +
> +	tail = READ_ONCE(swdma_chan->tail);
> +	head = swdma_chan->head;
> +
> +	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
> +		goto err_unlock;
> +
> +	desc = swdma_chan->desc_ring[head];
> +
> +	if (src_fid != SWITCHTEC_INVALID_HFID &&
> +	    dst_fid != SWITCHTEC_INVALID_HFID)
> +		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
> +
> +	if (flags & DMA_PREP_FENCE)
> +		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
> +
> +	desc->txd.flags = flags;
> +
> +	desc->completed = false;
> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> +	desc->hw->byte_cnt = cpu_to_le32(len);
> +	desc->hw->tlp_setting = 0;
> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> +	desc->hw->sfid = cpu_to_le16(src_fid);
> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);

Any field indicate hw ready for DMA? what happen if DMA engine read it
but sofware still have not update all data yet.

Frank
> +	desc->orig_size = len;
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &desc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(swdma_chan->submit_lock);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
> +				       flags);
> +}
> +
> +static dma_cookie_t
> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
> +	dma_cookie_t cookie;
> +	int head;
> +
> +	head = swdma_chan->head + 1;
> +	head &= SWITCHTEC_DMA_RING_SIZE - 1;
> +
> +	/*
> +	 * Ensure the desc updates are visible before updating the head index
> +	 */
> +	smp_store_release(&swdma_chan->head, head);
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	return cookie;
> +}
> +
> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	/*
> +	 * For jobs where the interrupts are disabled, this is the only place
> +	 * to process the completions returned by the hardware. Callers that
> +	 * disable interrupts must call tx_status() to determine when a job
> +	 * is done, so it is safe to process completions here. If a job has
> +	 * interrupts enabled, then the completions will normally be processed
> +	 * in the tasklet that is triggered by the interrupt and tx_status()
> +	 * does not need to be called.
> +	 */
> +	switchtec_dma_cleanup_completed(swdma_chan);
> +
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void switchtec_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +
> +	/*
> +	 * Ensure the desc updates are visible before starting the
> +	 * DMA engine.
> +	 */
> +	wmb();
> +
> +	/*
> +	 * The sq_tail register is actually for the head of the
> +	 * submisssion queue. Chip has the opposite define of head/tail
> +	 * to the Linux kernel.
> +	 */
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_pause(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int switchtec_dma_resume(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(0, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  static void switchtec_dma_desc_task(unsigned long data)
>  {
>  	struct switchtec_dma_chan *swdma_chan = (void *)data;
> @@ -721,6 +944,7 @@ static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
>  		}
>
>  		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->txd.tx_submit = switchtec_dma_tx_submit;
>  		desc->hw = &swdma_chan->hw_sq[i];
>  		desc->completed = true;
>
> @@ -1047,10 +1271,17 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  	dma->dev = get_device(&pdev->dev);
>
>  	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
> +	dma->device_tx_status = switchtec_dma_tx_status;
> +	dma->device_issue_pending = switchtec_dma_issue_pending;
> +	dma->device_pause = switchtec_dma_pause;
> +	dma->device_resume = switchtec_dma_resume;
>  	dma->device_terminate_all = switchtec_dma_terminate_all;
>  	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
> --
> 2.47.3
>

