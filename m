Return-Path: <dmaengine+bounces-7432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB7C98CF8
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DEE3A4ACC
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2C23B615;
	Mon,  1 Dec 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSYC/yfE"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42C22B5AC;
	Mon,  1 Dec 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616285; cv=fail; b=pk8q0H6WKNqYhQxR61urqAoz2T+aIXXyTvIsF5kqpvJhhmLyvRTIAG93uIgZyYVprNQ4ZSbFqKFn76+AjGGsq1Kkmb0g14lUm5v6fpDZCkNIH6GdUzrmx+pad4dkV6VyOTTlDdhCLlTjneLBgykxH8GdDU4Rgin3imv+ScciVQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616285; c=relaxed/simple;
	bh=jdL9zSud42Toa3RUtTBQkhxh8NR3+FJq7yNWT9OlGLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWW5QAbKm7Urut3NTl+jzc3r6m0yrKFCOU586ESd5Upm0LSWyduCA4KZMx9m77AsBULLJEgr9vr4bSH8s4Gsz+iBV01aGCGhQ+qEt4KFq90kXicePcU5pw09gDWFJtQ1Uz6g+x9Gl0yo+ol8tOHrt8Mo+qelaUhWPx7xXQC8un4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CSYC/yfE; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1G6mFSWRyJxkB1zxG0RvSc7ykesED7NKiIbhYntzZLc6zXw9ngeV8WwRRh1WjEDJ83pJqJNpx7UPpx8F5LUTAgsZIISnHuEfDBCwLMKLgi8kudfGi4L5wNj5WKOqSUa+tF0CHpxF35JBTxXUPV/kRU9NX5Km8DctLnS3aM2eT938YD6u6lquH6+bk+cvuDxe6joCHSjLL7tEFpH2vIkLnfZT7l3kDdRtSNTgDN8vNE/ervfzoklPsEqZ8dW4Oc5nGPlLppVqQ4cUcHiPX+jouYmXMvzCA8eZn0vOwA0U5MZ8uBu2mUaTX9yVVjarC2DD+w0W3Ej8BaJn7Y8JLP7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+ooulV+wTWSYb01Qs0mDDygQW9IMla3mm/GS9Rk0Jo=;
 b=Y0IhWEMLtaLJXZXjwyZspL1EU1cIbbIimPAT2p01rxOSXDd28wlWwtb/SjQoDaO16zXNlRjI4L7LSWkQseXbuGPDtzeHswBWlXCRgtqxrkGSVbOMQ+4oXpmb5K8HLbBg3rqumxAAcwL22Bl6p9zE38++auZX7Gmuvj24WlOXi89+ooh6LBiTGt0XC46+XQtsON2sZn5RSxhe9f6LXIYHoadti1cnkiX9HKCN9MsSZ6UxOpyjl+zsxWQA2scObqeSvXPxGzWzuiC7DqEWlkVT/hiXYJ9q1OS/FgjTK0C4rTOZPU//pB3W5Y5rCx9c/4Cotl1/bqjdrgQhIzGja4Ye6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+ooulV+wTWSYb01Qs0mDDygQW9IMla3mm/GS9Rk0Jo=;
 b=CSYC/yfENic4jS2L2L4YR2fmxU/I5zNBQ6Ji1IaCEgYIhUZsXi8luXTfxciNFy60zQTr0W/7gyj7DGt6jF+Se0wjHdhpuMcuSsnELyvmEejSFa+rTA2swriRcBp4pIVpObpoLKX18ZICjcrOyueovSOOS2emyKN6oem9zOht4WPcVjyjPhrqgVZefEHNvlH7SaN5WL7vV//vQ0ZWo9bfycGWkK5XZq5vim7cZsg3+hhT/sF2JUFqef8UxbZfBmb+pQIC56vIjyzkCppucElxF5ChyVXvFaDMUXfR9VBC4qi3F5sd5Jb7N5+pOr6uqMZGWVK1nCpRxyOSFYzCjsQqSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:11:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:11:18 +0000
Date: Mon, 1 Dec 2025 14:11:07 -0500
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
Subject: Re: [RFC PATCH v2 02/27] PCI: endpoint: pci-epf-vntb: Add mwN_offset
 configfs attributes
Message-ID: <aS3oS8kg7e2aI98R@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-3-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4187a127-97a2-4a78-e9cc-08de310d67e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGw8XuAMFJiyK12sLeyXpPqazgJ6wV3irFJpJ6ka4ZpTFCmwOyTSc6yHEX8r?=
 =?us-ascii?Q?+l6aS2NsVkhE5ibz94oBoMKIFu7Aa5zZQ+vgHP/J38Zqms69rqyvNRSiQBlw?=
 =?us-ascii?Q?0ObotZ0BqzTN3k1mc7mr0HV8TfBRRw6ZmKKgMLLw17axllbR+to+79SoxtUV?=
 =?us-ascii?Q?J+PZ4/1y9VY32zcfY/wfkzkrLHRVUEz0/QMy/C63pM45knGJeGdC0QIl819J?=
 =?us-ascii?Q?vc/HsE4bfnQKxHtYhBWvuJzRtZWA+qb1kwCzYosNU1JHUii8VJ5zhnuqYWlt?=
 =?us-ascii?Q?+H8p6GqwD6vVAt0J/qU5bMKSmemecCXsiMPpi5+tpgqmejrOCO0PRLSEoBDY?=
 =?us-ascii?Q?Ny1/WTYmo4CdBxzeCARlYZZBFgHh0NbJy7zEk9zYT1cCAcdP334iOEnx77CL?=
 =?us-ascii?Q?lMfYLuPLUSqA2BzB4AG5eGAQ0J1rLyDAiodyF5PRcPIVRQ7npK+W/VxmYDtM?=
 =?us-ascii?Q?QOk/CrlZlb5qRtjeFsfouaT90HIPNdrcYVb/KifnhIpwsqz0vJsScNKlbDHP?=
 =?us-ascii?Q?bf3DT4aQS+BbG4OJhGMVdQJRe4iMM7d6aoDecAoK+g46K7DIaflesMhLu8v6?=
 =?us-ascii?Q?N6IbGa6/O4ZTj6Z2s6eGV9qurs81MBLDeTOW30oph+TdmyLEc+vW9/dUcsbn?=
 =?us-ascii?Q?er/pxB9jfv+ssDn/bs8ZiVHidIE4leLltv8Tq9PfeKDVcteL2ciaStlA2TdJ?=
 =?us-ascii?Q?I94y9DIDyhjfMcs7pj8gd3r6P0kkR2FoU56ADQdrLVMSMQKko6j/i1a1UhFR?=
 =?us-ascii?Q?EmmRN6gaqewpfmbmAa2DCvwV0zZbLvfw9lINq7DlGURpUe2PTnX/+KFk70rW?=
 =?us-ascii?Q?KPsRhTYNCs5gALQ8yvE7MSPzc5XeTlmkepT60Dj1PpBJ3oRiV8bVRlshgkl1?=
 =?us-ascii?Q?tCleH1tKFUUtKNXHJkDF8xYRqxGjKxJbp41B6pn5ktOuFr/X4civtdUxNUj8?=
 =?us-ascii?Q?YENcp0GLvTpIxhBq81OG/cF3K8qc62zkFkphU004sdSEjIbF2qD1ET/s4n4/?=
 =?us-ascii?Q?mUoG+8CXX5RKfo8nizbW4yVmSKQnO7dWUO9dZIkHsL71mI9llBLU5FkAV/Mi?=
 =?us-ascii?Q?4XambeMowP2kN4kHujAh4teC/0FVo5kNM+186hIOx9kPX0XJjjIhoWFiL53m?=
 =?us-ascii?Q?zOKMor0Fekhk98TdgCqr0ohDfNL6F9Uc2ntsHoZyNe5gfWhV4bGiOOhdAh9f?=
 =?us-ascii?Q?sIkS9gCW4ZDMMAM8AaWP3Z9HpWaZ5XTZG4zkAmdVSRKv1bTvaE0MdEy4ZPtW?=
 =?us-ascii?Q?CMh4YBjBoy0wKb4E2x2zL/Q1sOMgUzKh4rxHnZCOrtOH9X631jZW7An2ZMS3?=
 =?us-ascii?Q?BA5yQpTJg/uxsel5KeFr1ftS0kg0/gMNzeN6Sd1gnDICPxWsQsRhQjR4+Tr7?=
 =?us-ascii?Q?snagkG+k1/DOUEszaUUeT2tKA+Y8Szz5psTKeBkJK8G8wLubKQxCv4/zdMpH?=
 =?us-ascii?Q?Kbbgjo5jSsMHJ6jw25Pt6jbQxns0tiQJ8IQOnGZFmH6M24IhTfseIqzIUvSz?=
 =?us-ascii?Q?dslMczOw6X/4ukCmeFluD0I/f+G3Mhk3xqrm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPMBdmcq+2lbRZbOeESVOt5L2w26ekAtkillL/KLicbJAomOurVl8TN6P3Rl?=
 =?us-ascii?Q?9CRdCD0EhO7REt+b0UKx+5n/z8RsLlEppGu+aqxO73A4bt36rU6JlKnUQCR8?=
 =?us-ascii?Q?1GM/eKA7ca0AH68YuC6rFEXn/5P0sduGOfRjBPSL8nq1Lm/eoqN5UFcQzUAd?=
 =?us-ascii?Q?UKlxilfsci1+niq6aT7qUj54YczspVdHOZJeKpVSgE50GYfBO+QQHwPkiSmv?=
 =?us-ascii?Q?wd94i4vvn8wdMTlUtw3CBEc27NAjepAjx+oEv9gz0tmXdsKZYTCu+hq9s/LX?=
 =?us-ascii?Q?cWkvJYIBqNr3k4ICyInv0RCv15MJTnNEL6ggsXzmPkPInQxzyfs/EIDEcR1+?=
 =?us-ascii?Q?ruGy/DkwgzQdhsi+p27/uhD7Nhu5ibydYKpKfXxejEVZqfk1k5qPvOTJ/C3f?=
 =?us-ascii?Q?my2KumegItsWhsojh2FZFMdsXMqMifPmS6ENk0rofIrT8Y0WybOBQG1Y6R51?=
 =?us-ascii?Q?zl6ObkC3eGlyJJ2RFnWmDkBWWhXLIvvARQdBv7rNt3FDUWvQ8A0rc+jEQIcL?=
 =?us-ascii?Q?urbUaGef7c/U968457utyt9Xuvy1QGQqb23cylP1Op/uylERFv/hM58GRTFa?=
 =?us-ascii?Q?qLO/JloJrWZupLuuh37KRGLHUua2Nth01KueWG8tfNomTloZPuw1oCVDiOrm?=
 =?us-ascii?Q?TDn9csjj2dDfUQPCHd2F+U2dOm17T/6AEG8Nt5DfWFKrtB0dmmuMo05DCCD2?=
 =?us-ascii?Q?SiWzzLNOu0bixaam72jcXcmIrgysOjfgrsOwO4qawhkfrjaYf8mhDoohrkV1?=
 =?us-ascii?Q?vVLyF7+Omy7hQvWah+eLfVh7Guzgma8rEWRVhNe3xKPIzKMy3hMNEm4PYq/D?=
 =?us-ascii?Q?GReIkwr4c1yLHWeUI3bLB0oo1iPYJfSOyQgrRpSCEKqv9KYczVXvMlkK1T9e?=
 =?us-ascii?Q?PgqLUAW5ldppPA9o8v4V+ux+rACvdtUkXmB1BOPZ6a/CwihE5Agwq8LE/dv+?=
 =?us-ascii?Q?w4Jmd2NarPfaMs2fBNs1KSC9j1WyvVMYUcBivSb4o84KqvpyiWdTBhtrkyr4?=
 =?us-ascii?Q?FdRwujBcwcQv8H+r5/XdTznkFxq/iddSFjNSSQTo8OfSL7nA7XaA36JCAMqP?=
 =?us-ascii?Q?FwIFXiRfo5KAJIdLU276XlInYDj0udnfUhiqeTmncV4EKBtpeEPQQgcZr5/o?=
 =?us-ascii?Q?pMmDIX8Zyn6OgFSq2lbS/P33lLYasUHTetugxHYzx0Lw7rqpIxvenaoe2dGs?=
 =?us-ascii?Q?lrIYRs0IFcM1pebD6n+HxLILtLUPYP7IiynN7d15/oO/LhjX+PDfxV/ai7de?=
 =?us-ascii?Q?ajs20SAkvvteWflBmZU2/70JZ0F35s/rcH/rLd2UM/kaDK2ZEfrnJItaKSmb?=
 =?us-ascii?Q?3NRTuNnYliPwhIsY1+RC3tJjNOEcJS+nSjyYCShwcSrVcjW80lQfhLD+I5QG?=
 =?us-ascii?Q?QSbpNZRemAYDvvo0pYOuIqq4k3of6M/yz6uH7JC69wpDMgS1QccUo/NtShSr?=
 =?us-ascii?Q?U8DFynaOLy512qPxHykU6H4E0eJergjNWkUBsXsn2xqCAQQn5oxUbZS+3JxX?=
 =?us-ascii?Q?TDmx31vy4M+/NTXLf6Ic/JAGhuPenVHiK0rhmTf+XeM7ME5mdwDlR2KITge3?=
 =?us-ascii?Q?uXM/6GbRB5/4r04xprT5Ss8/xfQHH9PyCLWwF6l8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4187a127-97a2-4a78-e9cc-08de310d67e5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:11:18.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wkfd7gMgbEArNa7dYdqPppHl3PTFb3UbwCiV7GIPEzxZnrBIEgi/8/LtYj8thqOgUjuvcCo8SwXKFQMsbsJRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321

On Sun, Nov 30, 2025 at 01:03:40AM +0900, Koichiro Den wrote:
> Introduce new mwN_offset configfs attributes to specify memory window
> offsets. This enables mapping multiple windows into a single BAR at

This need update documents. But I am not clear how multiple windows map
into a single BAR, could you please give me an example, how to config
more than 2 memory space to one bar by echo to sys file commands.

Frank

> arbitrary offsets, improving layout flexibility.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 133 ++++++++++++++++--
>  1 file changed, 120 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 6c4c78915970..1ff414703566 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -39,6 +39,7 @@
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>
> @@ -111,7 +112,8 @@ struct epf_ntb_ctrl {
>  	u64 addr;
>  	u64 size;
>  	u32 num_mws;
> -	u32 reserved;
> +	u32 mw_offset[MAX_MW];
> +	u32 mw_size[MAX_MW];
>  	u32 spad_offset;
>  	u32 spad_count;
>  	u32 db_entry_size;
> @@ -128,6 +130,7 @@ struct epf_ntb {
>  	u32 db_count;
>  	u32 spad_count;
>  	u64 mws_size[MAX_MW];
> +	u64 mws_offset[MAX_MW];
>  	atomic64_t db;
>  	u32 vbus_number;
>  	u16 vntb_pid;
> @@ -458,6 +461,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>
>  	ctrl->spad_count = spad_count;
>  	ctrl->num_mws = ntb->num_mws;
> +	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
> +	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
>  	ntb->spad_size = spad_size;
>
>  	ctrl->db_entry_size = sizeof(u32);
> @@ -689,15 +694,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	struct device *dev = &ntb->epf->dev;
> +	u64 bar_ends[BAR_5 + 1] = { 0 };
> +	unsigned long bars_used = 0;
> +	enum pci_barno barno;
> +	u64 off, size, end;
>  	int ret = 0;
>  	int i;
> -	u64 size;
> -	enum pci_barno barno;
> -	struct device *dev = &ntb->epf->dev;
>
>  	for (i = 0; i < ntb->num_mws; i++) {
> -		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> +		off = ntb->mws_offset[i];
> +		size = ntb->mws_size[i];
> +		end = off + size;
> +		if (end > bar_ends[barno])
> +			bar_ends[barno] = end;
> +		bars_used |= BIT(barno);
> +	}
> +
> +	for (barno = BAR_0; barno <= BAR_5; barno++) {
> +		if (!(bars_used & BIT(barno)))
> +			continue;
> +		if (bar_ends[barno] < SZ_4K)
> +			size = SZ_4K;
> +		else
> +			size = roundup_pow_of_two(bar_ends[barno]);
>
>  		ntb->epf->bar[barno].barno = barno;
>  		ntb->epf->bar[barno].size = size;
> @@ -713,8 +734,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  				      &ntb->epf->bar[barno]);
>  		if (ret) {
>  			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +			goto err_set_bar;
>  		}
> +	}
> +
> +	for (i = 0; i < ntb->num_mws; i++) {
> +		size = ntb->mws_size[i];
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
>  		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
> @@ -723,19 +748,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  		if (!ntb->vpci_mw_addr[i]) {
>  			ret = -ENOMEM;
>  			dev_err(dev, "Failed to allocate source address\n");
> -			goto err_set_bar;
> +			goto err_alloc_mem;
>  		}
>  	}
>
> +	for (i = 0; i < ntb->num_mws; i++) {
> +		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
> +		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
> +	}
> +
>  	return ret;
>
> -err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
>  err_alloc_mem:
> -	epf_ntb_mw_bar_clear(ntb, i);
> +	while (--i >= 0)
> +		pci_epc_mem_free_addr(ntb->epf->epc,
> +				      ntb->vpci_mw_phy[i],
> +				      ntb->vpci_mw_addr[i],
> +				      ntb->mws_size[i]);
> +err_set_bar:
> +	while (--barno >= BAR_0)
> +		if (bars_used & BIT(barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
> +
>  	return ret;
>  }
>
> @@ -1039,6 +1076,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	return len;							\
>  }
>
> +#define EPF_NTB_MW_OFF_R(_name)						\
> +static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> +				      char *page)			\
> +{									\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	struct device *dev = &ntb->epf->dev;				\
> +	int win_no, idx;						\
> +									\
> +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> +		return -EINVAL;						\
> +									\
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
> +		return -EINVAL;						\
> +	}								\
> +									\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	return sprintf(page, "%lld\n", ntb->mws_offset[idx]);		\
> +}
> +
> +#define EPF_NTB_MW_OFF_W(_name)						\
> +static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> +				       const char *page, size_t len)	\
> +{									\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	struct device *dev = &ntb->epf->dev;				\
> +	int win_no, idx;						\
> +	u64 val;							\
> +	int ret;							\
> +									\
> +	ret = kstrtou64(page, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> +		return -EINVAL;						\
> +									\
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
> +		return -EINVAL;						\
> +	}								\
> +									\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	ntb->mws_offset[idx] = val;					\
> +									\
> +	return len;							\
> +}
> +
>  #define EPF_NTB_BAR_R(_name, _id)					\
>  	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
>  					      char *page)		\
> @@ -1109,6 +1200,14 @@ EPF_NTB_MW_R(mw3)
>  EPF_NTB_MW_W(mw3)
>  EPF_NTB_MW_R(mw4)
>  EPF_NTB_MW_W(mw4)
> +EPF_NTB_MW_OFF_R(mw1_offset)
> +EPF_NTB_MW_OFF_W(mw1_offset)
> +EPF_NTB_MW_OFF_R(mw2_offset)
> +EPF_NTB_MW_OFF_W(mw2_offset)
> +EPF_NTB_MW_OFF_R(mw3_offset)
> +EPF_NTB_MW_OFF_W(mw3_offset)
> +EPF_NTB_MW_OFF_R(mw4_offset)
> +EPF_NTB_MW_OFF_W(mw4_offset)
>  EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
>  EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
>  EPF_NTB_BAR_R(db_bar, BAR_DB)
> @@ -1129,6 +1228,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
>  CONFIGFS_ATTR(epf_ntb_, mw2);
>  CONFIGFS_ATTR(epf_ntb_, mw3);
>  CONFIGFS_ATTR(epf_ntb_, mw4);
> +CONFIGFS_ATTR(epf_ntb_, mw1_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw2_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw3_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw4_offset);
>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> @@ -1147,6 +1250,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_mw2,
>  	&epf_ntb_attr_mw3,
>  	&epf_ntb_attr_mw4,
> +	&epf_ntb_attr_mw1_offset,
> +	&epf_ntb_attr_mw2_offset,
> +	&epf_ntb_attr_mw3_offset,
> +	&epf_ntb_attr_mw4_offset,
>  	&epf_ntb_attr_vbus_number,
>  	&epf_ntb_attr_vntb_pid,
>  	&epf_ntb_attr_vntb_vid,
> --
> 2.48.1
>

