Return-Path: <dmaengine+bounces-7438-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F54C98E1F
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497203A44B3
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA023AB87;
	Mon,  1 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cr+KdqPE"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAF21ABBB;
	Mon,  1 Dec 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617981; cv=fail; b=M2uQpJCQChadL5mmvYhsVgekKDe1XYoiNMtG1LEKfxvFzIJy18OkCsgqjWmvC9cx3/FrEesRQdpAzghdfwDuVVWph/Ntkh7T+H9N2qrkZZdoRSlByiqZtuc3ZBz3K1N35H8MQwT1rQihOj78SUn/oSZ1qbURPO3SeXBA4a84VTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617981; c=relaxed/simple;
	bh=e2X6yv8BidJzo8O+BiQPviZ5j3IiFJXxDsI5tUr0WnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZVawgvu+S3FnrnCpfiSIgWgW6W5cj18Kya52CSLqXT9xqTHy8VYN2cpO67f7LAnl6BPccSuma9ERqwkMnjCqCcT9jCkDQQol9MxxCpvvx3cKZHFSfoJ5WJZUwSlTOSjLF7udeHwYJAihCzown3TTxitxptgJ3DqSvlnF++7Ix0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cr+KdqPE; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcAQ1glXkNo0oucXSwj2EhZTv3T/fiixKGlZdHCtTbv2k1ZUNPLqTVZm5QPxbPMjsxj8bk+wt5Ml2t4wnybZD3/qfnRoL+w/yx1ps1DMtaWXKK64ozMWIZmUNRdRviXp3imb9btS1UXyCVp7EtXFqw/KzAY7JSDKgPfofgZVGtSFAVFSKoXvHJyr8ryrCT40GYUo+bezwSWw5jaYxBKplkS2bYnl9WFzr8lOiEark/W3juRtAl1eck+nJ6m3GBtXCFpf2+MqABl1KQHv9nOkUeIJU1I+/ldUm+XArFPdIQTGpzbMBIXsf47Tc4K4+iRQHttuC5frZH3bHJT81uWxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER58KHyki0bijZZv2wImaT73wSX9+ccVYZH8TPb2/EE=;
 b=FO/rqEAuAjWxvIYbhKjSHpynLUquFZCAA/gL5lS/3GawvNr2tqFUdvCoydrdA1y7KhDj5IbrBKpUuE3Sm5Ta06RkC72RMQt7BNPBVIp6go5b8FNZeYgDs0fK9jwM7A8jWS+21LfPBhJoBaU35VRY7b9gO92tqnmSF4oWbpptMZ4Goxec6KtqwZEs4d8OhCAAuQrzLoe4rKb/6k6mexwwUBlZl85j6c7uKBlIiDy8rolpYFNGeF4C55HoHcVmPJJcbt64LOLm5BBPkkl8QixaggdNLrm1ORIS004ZAbfQigBjM5tOIOGRjgOKFw1/CUq4N6aREmuW8vLnh4A6O08H5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER58KHyki0bijZZv2wImaT73wSX9+ccVYZH8TPb2/EE=;
 b=Cr+KdqPEY/vZzHipvGdMF+dacq+e0rCmZuu2u59Zb3/Nhm4nYdROfl+jy/wOiPDjGk6uU2ssxfEq8Xq5OTc+NR1UcPYdt/JzLzTdZjMciMnI10UZtINwVnwgmpo7IGag22NadScNiSrU5VJ5rKCQ3bdT3cogDnOkOyGprg6NPD3wxkzzlFM/tQLklBVJxzB22HorZguxxy5GcNnU3Q8/l5mq/64GkeMHdSSK6tP/6zU1LMmmHt8nHWgT+HN1ggjzBFZdBuryeFU4YRjBeEQHhmuXxGGqC+olIsKRpMsN7kLgu8sFN63ENAGE7qko5Ln9t6bS57C2vqQ6KIOOCz6ECA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:39:35 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:39:35 +0000
Date: Mon, 1 Dec 2025 14:39:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Message-ID: <aS3u7Ub+yY1oWD9i@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-11-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: b025db81-5411-4a07-9991-08de31115b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+ApbhSPuF01Imqtb0BDq1c/O9TL5VfLMcNFBYPVn5TMvz3zaxTSHeHqlj79?=
 =?us-ascii?Q?xK1yhzhn3hnz29qKVH/oLLzoawaWG7nrh/bWaZv2qbJluUMoltKmOaGnVnN9?=
 =?us-ascii?Q?SV38zxCOYET0xqv05fbh/QILfTHVj8u6MHRsNcS1vhEC/iAQPC+hR6g59dI0?=
 =?us-ascii?Q?9Sb1+IbKLd802fzAa+pe63alz/2/CA7zA3JhfimloTKJOA8jair3czncwaa5?=
 =?us-ascii?Q?L9x6uh21Cqleu7JxdzrO81CDRXsIMmFkjD9jYIXGpEQHV+Oi+HNiiQ55Wma4?=
 =?us-ascii?Q?KKx/eY9b5zzs365iXFHL7L/YTZ3WQaez49phaCpsV3NWcF2dzoDyzVnrzGjO?=
 =?us-ascii?Q?cYIkNrXSz8sHX1oOqba3W+00wRlFW0V9lWavyQQuYUCNUkLUByhkWjhMcjFF?=
 =?us-ascii?Q?7xvCkBY69KXKW33w4TAxJO/94naxQ4DAjS923IkyR/FdWikQTvQhvtIcPu2n?=
 =?us-ascii?Q?7//agZNn9BVW7fS+hxlacE/OmZMEvg8bDI5gpOx1BmHOGihyFnDWVIu5pK/6?=
 =?us-ascii?Q?MRE1h81f1Ofzx5euAC3lftHwGYAzwExYvEzoCpT5x9GNajDc2MukwhE8x/8a?=
 =?us-ascii?Q?82/I021mEucf2UvV8uqUBNzgxcXg3JgfexAPi9W3YEXnVcdOmjULAiL+KjZu?=
 =?us-ascii?Q?d6kMmEiA+sBgtvCE61aHrMrp9bS7sIQEdFMFNkgU5nkwTSYtiFxMDNo0pQ7K?=
 =?us-ascii?Q?DzRI1Y4kRnh08nsihIiuuDr0R+FFBJtRkZW80yOkYUF7yX8xlU6e2B/tWCG5?=
 =?us-ascii?Q?DZTygtM+AJgTmVeNC1HQCXkP4qLA4G3cppEn4qywBTI28gz+bxG/NiJ4seAu?=
 =?us-ascii?Q?7twlL1CgAytGWGHYiX64TajKau8OoTpL7HzWDYlrUA3drVKnc0vYmfol3TJJ?=
 =?us-ascii?Q?ZvqpBrS7eXoQxsnuI/o3jsolLuDQLecAl34BNU/zJH4Z7UhjvBjE9iIvTdeY?=
 =?us-ascii?Q?D5WQmxJFOq8hwuVPQZYlgkobuOZDHdVtYyTtjMZ/fJ/T2JcgaqHUjlHDyr+3?=
 =?us-ascii?Q?vkIwQP5QpHgGyvPdG2OshDc5fIBWGustiIOjg5OcWKITxScVmj1YAaKM1KNI?=
 =?us-ascii?Q?xeIRTK5LGzP9JiEPI4Dr+sR2SGVL+kke+eBcihMRXSJwc0+ytGCSeK4zXIzN?=
 =?us-ascii?Q?E3EQilfwMygLhn3Qe+I4hvHHJZ8FX8O8mDpUU3Xq7SypkHyX/fsejEXfLqXO?=
 =?us-ascii?Q?CZLUJRmETpuDMozXUWJVvMASVWM8AlSNyD5COFokJhSe5XmqZPxztXbe7i8f?=
 =?us-ascii?Q?WRv2NZOGw/FlrDwLP9BSMTPmfK+X6K2EtKPEt35uoS0DQRqDf3aM/14OFUfh?=
 =?us-ascii?Q?6BKQ/egXA+4VgOfgvA2EKyLLcimH6X0FFTJhEKrVRgw91mR79cf1PbUDGeCK?=
 =?us-ascii?Q?bGBKInmPUhEJcMBkC33gR43JSEryQjgBHnq07LHJ8BINO4XJXBfEJZE/KYPB?=
 =?us-ascii?Q?kkG+Uo9vqQpzFwPImTLjrbS181tU1H244j/EdCUyxvU9pZQ+OfsXOSze+bSg?=
 =?us-ascii?Q?6cSzt0UJo7ylUfq+zGSSlwBcxM0W7tmMgS+T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46ITLeqhSmgE0G/lldWPEMxLDbFWqSLpBlHTaB4GBz8o5hb/0az8Z1nSqgWU?=
 =?us-ascii?Q?tsPS19/VejVebliJwIqtMO8WZXplxUc6M+6iUjtj3d+Ixh29d83DzsDETH6W?=
 =?us-ascii?Q?StUpIGu/yEzKIB2/RAuIOfH8IS5osfl67tbMsAP4NZmvTChuL7kotNosSc+9?=
 =?us-ascii?Q?+NnntCGiEn/zlw37926tH1bEYYvkfY4OorE8T/k/oVtlVVkp4XjkZuVTxT3c?=
 =?us-ascii?Q?wXEPgMOTb34foIV6yiMICjmvZrV3Cjw99pYc3OXJ1yGd/7Hml2YSIO/cMRzQ?=
 =?us-ascii?Q?d2vqzCMmlxx3DQpiEt0Hs02mZwcUmDRhRMvSAwCU+Qo1Fz3GEmubR28cQqKb?=
 =?us-ascii?Q?ROlXvx08VUZw3ft54cKjESmPDAPvvj59wS8ITf6KW8LsrQ7i7ZeT8ChR3T52?=
 =?us-ascii?Q?s0wJObnsH4fgcBRvfzOCQXFJyCu04O0OTuIW9xFhY4p1G2ThOvolK8oEk75z?=
 =?us-ascii?Q?UM9cVQxV4Q39BFVXhjxJUl7mQTmbZkbmoCA3q6OksvrKFygIDsRCBpVon5dM?=
 =?us-ascii?Q?SrLXWg44XS59ddwYo0jIi5Eo85klMFxM1TOg/vvD42NdakmYP+0SPBFAMAJo?=
 =?us-ascii?Q?bIewvfdMW1yHANb/nB0z5aUTiNDo/81JfkxLIpoMx9FGeGHW4x/HarCUT8IU?=
 =?us-ascii?Q?xgaMMFl1RGUHaHah6J6ZLgbx1Kq5eXNcSoWVODfPEfXQtdygvnaB2a9G+Deg?=
 =?us-ascii?Q?/GE4JPBsPlA8dndjFp0Ug7HgzqhoZxTTmlejnVqzbOQ8vvTTcprta8vUxXGj?=
 =?us-ascii?Q?YyyIe8zTA4u9bnXM3NI1ltQKlOpOPXFZsFS88tT9w+z48OJZBvcIZz9Aoucm?=
 =?us-ascii?Q?7+Sy69o8ThAgSaf6L0LrFWHyoLnPbWfysLr5639zeItKRyqvRj/IhEKkSX3E?=
 =?us-ascii?Q?JEIm95EsB+5aN3+15QyJ3Y6O0PJsFCwqFY+DgH5QghIRDx97hLFTxDY1GpBn?=
 =?us-ascii?Q?PesuLk61hqtTytnuf6lWqdlNnG4fio2pA0NzzKJ8TLKFAQCZkEeSlO3p+q0/?=
 =?us-ascii?Q?u83OIMkch41E/NFUZ8Vkl4xLHPHRWW4FQ9OayQUihW0qtiAPpEqisXYfEJLJ?=
 =?us-ascii?Q?5406SpSWibtiAfr1wvSjhUhU/nrL9SmcXlvWnC3jQxQtKdgyFH8F1d81EnXg?=
 =?us-ascii?Q?BJwTHoxyl0fakn4O2Rbhb8NHMafRfx7HvjxSVn7g8W7DLz71ItfZaadzfi0w?=
 =?us-ascii?Q?9Q6+Hd9HOXKoJOsCqsXRGFSWnIPl2vrymu3KuZ6j79I1MC2UiN984ZyW7uud?=
 =?us-ascii?Q?Vpkky9SNvCUm/A7NzMj+bwpUfq1MdmEMiPlIlvAlrsGB6yfODjc5hSXrQ4Bw?=
 =?us-ascii?Q?xnGykWet6qK2o5StJohWiW06qGyzTXpPAlf+PpFe3rdIK1NpKoCryiV98WHM?=
 =?us-ascii?Q?o8CDVbwTdP8gxrCl0uoUo3odXc8boTy2D0zaTIBiiwsuWylTDbGiQDpj9tu5?=
 =?us-ascii?Q?Xx0RQjuERB1i4sj1fBNCssdD7ajhMi6XJViWek62aIFmA3ljFYfxwUr/5yYM?=
 =?us-ascii?Q?i/N1HJ2Qe/medVNQomgeOplYAyv/VtGnA/smIUVeuQoDf7XmJqcssSgaQKXn?=
 =?us-ascii?Q?vBycUlqQXSj8J1cpYZUsb/wY3lOl24RGW9zjLB9v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b025db81-5411-4a07-9991-08de31115b87
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:39:35.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJLtiB79B7pfUfE7e6dc9qV6MD8XZ8T0YGbb+IUvKSiePPf2TOyav6IlJ6wD/mzLZebLf9RelY64CG/m76+H4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526

On Sun, Nov 30, 2025 at 01:03:48AM +0900, Koichiro Den wrote:
> Add an optional get_pci_epc() callback to retrieve the underlying
> pci_epc device associated with the NTB implementation.

EPC run at EP side, this is running at RC side. Why need get EP side's
controller pointer?

Frank
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
>  include/linux/ntb.h             | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index a3ec411bfe49..d55ce6b0fad4 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-epf.h>
>  #include <linux/slab.h>
>  #include <linux/ntb.h>
>
> @@ -49,16 +50,6 @@
>
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>
> -enum pci_barno {
> -	NO_BAR = -1,
> -	BAR_0,
> -	BAR_1,
> -	BAR_2,
> -	BAR_3,
> -	BAR_4,
> -	BAR_5,
> -};
> -
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_PEER_SPAD,
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index d7ce5d2e60d0..04dc9a4d6b85 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -64,6 +64,7 @@ struct ntb_client;
>  struct ntb_dev;
>  struct ntb_msi;
>  struct pci_dev;
> +struct pci_epc;
>
>  /**
>   * enum ntb_topo - NTB connection topology
> @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @msg_clear_mask:	See ntb_msg_clear_mask().
>   * @msg_read:		See ntb_msg_read().
>   * @peer_msg_write:	See ntb_peer_msg_write().
> + * @get_pci_epc:	See ntb_get_pci_epc().
>   */
>  struct ntb_dev_ops {
>  	int (*port_number)(struct ntb_dev *ntb);
> @@ -331,6 +333,7 @@ struct ntb_dev_ops {
>  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
>  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
>  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
>  };
>
>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
>  		!ops->msg_read == !ops->msg_count		&&
>  		!ops->peer_msg_write == !ops->msg_count		&&
> +
> +		/* Miscellaneous optional callbacks */
> +		/* ops->get_pci_epc			&& */
>  		1;
>  }
>
> @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>
> +/**
> + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
> + * @ntb:	NTB device context.
> + *
> + * Get the backing PCI endpoint controller representation.
> + *
> + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
> + */
> +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->get_pci_epc)
> +		return NULL;
> +	return ntb->ops->get_pci_epc(ntb);
> +}
> +
>  /**
>   * ntb_peer_resource_idx() - get a resource index for a given peer idx
>   * @ntb:	NTB device context.
> --
> 2.48.1
>

