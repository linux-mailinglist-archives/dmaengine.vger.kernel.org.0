Return-Path: <dmaengine+bounces-7431-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802BC98CAA
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66D94E2347
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE13244661;
	Mon,  1 Dec 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/iseUJF"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1881E2858;
	Mon,  1 Dec 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615627; cv=fail; b=OtevfgkdEGDSzKT7cl15Oba6j2lU0WPUPLbWMIajbqpeBzgFcwmrA3goY4RTjcZq8wI+NDVA2Lg3QeT4Is/EdgE7P+IowhgsfaoQr9fYggW1TMGymXnS3BU/3Qq1NC5okgOp/g63yT5UI0yKjV7stDb8ogTgzTXY4yqijeZcN58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615627; c=relaxed/simple;
	bh=C9H88P1U18XTyKqHiHSLkXJ68qeiGoXUX0iwMCIKXOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZLrvZX7TxB0b/rNP2uGUnmC1onSIP0+1m4H0UL787WcDlR/gghYqxKIYNMYV5NUoN3UzR4xhbaCwnSttYaDGI7pqZtqSKyuVatsjP0HcJ8d+2/iiIkXLNMUFhftf7Sq26rOK2ueD/yipHGfK8Z776i3CpZHsUJ9IVVEK4IRIUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/iseUJF; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0FMcr6olxUfnzP83F9zXp3htbdEhBFt5A06QzU1v9ZXVltUj8g/qapbTiEbJ/jFYUCVzrIAhsKczyKNpx1A2XdQDTCDmNS3cVuDwjSaERaw9QuXr6wbxoYODW62ieTZGaiffxi1B9/bBAFnYu0nLq8BsZHLMQSaz8Jph2gKKNzZ6o3rqXBE/UxAoE/bAjDfe5cjSR+K3m0rHoTqCjGzQ4a+kn0jsEC4xt9zU4XtBpy3Jp4pGttI/DU+pwXZY8sLa3cFK0gG52m7UMvFer99FHBfToP/se2PwsRA+Z4Wvfk4k7sc/DeQIGw2DJz8BB1JVJ+377ZolHXzbc+bjEoNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jIhiGBZnx1GI5l4Aw5ZeZWjlqBcopZD+kweaA4CL5k=;
 b=GbV3HZzcrI73ncVNJc/TDHRWS42xzgW2GYR2N0qKwGk8QMe6URa2E2Dtch43HFQ5/ZtNImFglqZ2yFzVD/H6wwpcZrdqZCu3YodZMaSw3BnZzrAMBWzpRj67H2eNpX0x2M2osSPLr8vl6GDcCnQVS5KhykWDQdAgIW+uhq4pB70gSHEY+eqAyYxc1FsuwICUdBXVafNkI8o75SBouZ4fupU5BaCfbo5jy70eILP7P6P9xhLm0RAwDqWrtjHdwrqeLGfJMqT+xZ7cDXy8DiW9cEDgli7NMzuR0MhlSxWogKgBJjMhvZvCNHHdMEbcjFFPYLf9ykxxMbWhGwsvjekgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jIhiGBZnx1GI5l4Aw5ZeZWjlqBcopZD+kweaA4CL5k=;
 b=T/iseUJFvA9Pn0nZzQHLneQ+XMtXBwgz9xiiPuQf3b2LSYiO6154bvR/BXh1sHatp8UHxXpyGEiXfy7EWqVCUsohTvxE1fOZwzdA7REwCZEud68dD/qPSyeu1ECmXrPtB+aik/xGin1q224+oBzzSHOrxYba9PMTelZ0+iXAhlhEecROXXL1E2pWrwdyvjV5nYeoiufJ5D5+UUZsstAdDFFS/ncU7SK9yR8OW1D/WKVRTygnLJdK+DrZ1Se1BDNcCxMZVAGaGTW56RJFbaSKoqT65TEa7ylWLwJrtZ/5C39edlMeH1Eut761jOHCff1ZDMWMfNgL/rt32t7nCe1jjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:00:07 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:00:07 +0000
Date: Mon, 1 Dec 2025 13:59:55 -0500
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
Subject: Re: [RFC PATCH v2 01/27] PCI: endpoint: pci-epf-vntb: Use
 array_index_nospec() on mws_size[] access
Message-ID: <aS3lq70Suyf1i6aJ@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-2-den@valinux.co.jp>
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d4b475-b0c4-4b13-dbbf-08de310bd81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4Gl2ywD/l9AEveYNwf/ba87iomvAB+7O1pFzVbYXTdM+90AOmRhSDFt96UU?=
 =?us-ascii?Q?uOR/E/ajNvyrmi8EcmYaU+blOBhM2r4qOSiF/uu2B++aKeMzDTtKjlRBaDY1?=
 =?us-ascii?Q?8Icagi9OyI5jWxS1KoMlt8IV6C5Scfo7hNlKYPtZ/4lmRxJvU5su3rq+ZvqK?=
 =?us-ascii?Q?gs2gzh7hLsL3tSEJ7qADgF9zTpkmJLO2kISmK14S8h3ZMicI55qfbkm+Cm99?=
 =?us-ascii?Q?IKja6NmTxda94BavXqorrT5T7YXOltejc4BwRwwNGJAasQoC64cQx535eyuY?=
 =?us-ascii?Q?3PnTApngkIWnWXfgiFzNr+DNquEX/nl2Z8Vco+mJeIVdDgLNwvC6GvvGt9Z6?=
 =?us-ascii?Q?xB0TRIZdUaSbVGW8a3U+7VKroaddToBI350FCDXz9BJXS+l5DXaSi78Xlh15?=
 =?us-ascii?Q?iH8wqnlQygTtSEglfw+eROyRiiuiikXx4EhE4lW7zp9IwTvDHYLZg5p98qBB?=
 =?us-ascii?Q?Of6rz2p63+zws9dPvK0SfRbIlPQNJRtU/fvpm58Ktsn2BLC+3LMicomeHv5h?=
 =?us-ascii?Q?OoxKB2ge6S6uSzaCUK9Xh3RiS7e6WlhYOeaspzaplOhDUwEed+HdJZr6QFrf?=
 =?us-ascii?Q?5hJKo/jQdO7E03ES7vgUozxMSu7ZeBKsV/DV6fVGFSsMifK4Pkz3STE0he3g?=
 =?us-ascii?Q?lUJuUlPiHW5/2t6UruGFWeG33KKJkPH0d12Ri4eLG9SFLOWj9BxHAZUctfs2?=
 =?us-ascii?Q?58hJx7aZs212EKpBC7EIqedK1sjtluwwUlhpsYnrjLM9JcU+XxdwXfRM/e9n?=
 =?us-ascii?Q?Ps/5n///79Eb1MaSxcfYC/vsp9kZd85GY/COZkFJ3rQxAlm6VxV0pSc7KDwZ?=
 =?us-ascii?Q?twiT0XMw+brSJtBlt4deQxI0jE0qoxYFEu1BSywXpDOOHAoGsBMTWZLsmJBt?=
 =?us-ascii?Q?T500GB+a1AQF/+fJq91EWZPJfW+VIUtORPeI5mMu9686oDp7lQFrf1XkiIAm?=
 =?us-ascii?Q?az1oFPXBvGIO1XDq7EeYEAQaIngTHU1p5DzzArcWBj34wpvchDY0iFxY/Nmu?=
 =?us-ascii?Q?5JmIyUmlFT/LcMonhZh3ZMONBo2wiD6ElaX1+c9ZLkHavxd/uhXvcyRpDA3Z?=
 =?us-ascii?Q?Ha1PJHYyfyi0YyCwphWHfpBCGYgHp/n/2yQj4UF79jxjHgSfl5jgUg+oNfR0?=
 =?us-ascii?Q?pfoM0o96SHgophv8aoJ8u0yUUsPagGpkjeCsvwYEDq0dXEqWAnDHCLUgdEID?=
 =?us-ascii?Q?Jg9vt1eNx5YkukWXAOE4OaSB2H+LZwAIILchZ/Dm/qbuE+/XivPspMNoKYwr?=
 =?us-ascii?Q?TT5u1B64rRvZi/YGvN+LeK+DgGsZcD7876BpKM2RSRIhvdeCmgVqoHJ3WlUn?=
 =?us-ascii?Q?poxKfdbog6fqvtq4/aowfBNmtWdS+a491i6ef6mEqiTr5aZAjFMVNo5tAVOu?=
 =?us-ascii?Q?dmFr1xjj3mod2GA8BvqMzI4I11sqN0DdqH3+BnnLlgNStQ1+7Ggf7B/v1mcV?=
 =?us-ascii?Q?msh3EJigo5aXjVWHR8eGfBpg+RQXZl7pVXl7mbu0Dw5aH0pAz2HyZwOB++Xw?=
 =?us-ascii?Q?zygY6QrXah24sFFQ4UXGNjuFzsA+E+QPOLhU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uyZbRt76OAVQV7YFHA5TU7ywU4vAKA2EtbZm5O7+K2iPvtIZI4f48jRZbTA?=
 =?us-ascii?Q?ssuyQfs7mcb4N0/wQosTrYrvM/r+VU43EIQQw9UVZlugjW+sIhoz/wpVyBa7?=
 =?us-ascii?Q?F61vQFijhYAqUOmAIxfCsuTk5ppKiIilPULYP1pgbY/2xu985xW90uYELbxG?=
 =?us-ascii?Q?CTiVGwDL6vYc2p434dSUyp9QxoSJ0KJQkofqealvKEngzokANfG4eXhVer5/?=
 =?us-ascii?Q?Myr7j0tUu5iy9BZjhqHitV7GDV+TJikYa0aHpNobDZyWVql11Emhq5eiBlS5?=
 =?us-ascii?Q?FzAJp5VRKAeqPUHy9ekfG8TbfpPDh4WZvs8Aq2IfhQPmGoNmA9KbU3Qj1f/x?=
 =?us-ascii?Q?jHJBmAx1J1+YZx/Zl4eEesF8REvGS4h7fVSmAirND6dQx0bc0XKtNARFOhPw?=
 =?us-ascii?Q?zcFrIwl/U4pP/F15sKLWEPeOamhpEqL+eIYUaB/fmwlY67h4E+8KD2UoF6D7?=
 =?us-ascii?Q?Wao0rQnLoD8T0x8aR+u2OKaz8a5kJn7R7p7WmIs1MmUQ25jnSepwn3CPslvY?=
 =?us-ascii?Q?fEnYXKZ03kpY2ONyDVyXWWiu1BwZL1CxKBdpf/QeAQ31elPSevoSaQjh2k00?=
 =?us-ascii?Q?5LHayV9PRlGI6o+51+MH42fj4k848ii3xcCftqQhcv9/Ii09wUnk0dafX694?=
 =?us-ascii?Q?OI1Buswd+/NJqp4zyni6LA2AdvKy3G5oP08FABe3mAhSQUiKJBXYhDjt050U?=
 =?us-ascii?Q?W1jX9/d8pzv4U8L8qYmdOP7EHKxw1Gil+xuOYinfvsyRQYmW3fLmdf0q9bvb?=
 =?us-ascii?Q?SNK6Y1WkuwL/8qE394xThjoHBLOTNz2RF19GfYv7h5iP2jm5VGSnqWSXB6ul?=
 =?us-ascii?Q?ehfbUDlTQklhjODseC9EkaPMX95OK8qc1WgTQFEQixsjzrYDL2gzgW2cBI/R?=
 =?us-ascii?Q?sybq8ggLo7ERPYX2P3TFjr3sytMAYqDig0NcYrVDn8KDE6xMdUIB02j2d2AB?=
 =?us-ascii?Q?wTZy0UoJLJ/YgQsjMsESDKvSnPsQZC8nngbjI4INW9qCLSVruGVGUoqG4y5I?=
 =?us-ascii?Q?BbfDIRD14p5TWEm9oS1zG32UPwL4m0EGOJ06w8eVJpV3bNcNgZgMqYlssq5w?=
 =?us-ascii?Q?MZt6CQcSZ10P8Bhq2UxfWa99wAsqHbXGcOyMYVEotwBT6hGvfDzenbfEmhn8?=
 =?us-ascii?Q?x5Vm8dgPeNQdKOGQW1xmHubO8bia9cfPpxCt70PR0yL+xqFPpDhRCW5raiH8?=
 =?us-ascii?Q?tV1bmcpybHd8SvsxK/VFXjxMbY8Rs0YNrIJNXui903zP9qnvhjRGjUmnJIrY?=
 =?us-ascii?Q?8PKl+lFLmStFeoeznP5D89drgb6wWMs16GqkZ6VMhQg2xLLJrrFZrOZuw52J?=
 =?us-ascii?Q?PpzEVl0Tul+RSzbsCd0oYPNAxHBushhZNCwPy8C9ZtqRY+6AOJBfz+5DJ4xj?=
 =?us-ascii?Q?6OX78t3ce2M9Yw7C3aRzbxj7yt13lM7G4DIICnRN8JNJCppPgRLLgj/aFN3t?=
 =?us-ascii?Q?HqRoahzrTJ0qKjnnN/z4WfDjdJ3gpG/TGOX7QOKQwWE42s6jQ3zbaED8H3wP?=
 =?us-ascii?Q?HPZaWh2Ij+HS7jLeXo7EuMFsydajCmqco71ZeeqdZ9QvIdu4ySuGhpbH4Kf3?=
 =?us-ascii?Q?ZRc/kU2dQ9c/t4X2rFP4c6Bfr6Ttj3OLlHhkRE3O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d4b475-b0c4-4b13-dbbf-08de310bd81d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:00:07.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sLjKS+Jsn3T8hl7nhhjLggUXTMWCntyfDtwUYdnbNQZYgsjUZPzBAUSL3Y8AdWVHLDdrKomuI5MXTs58yd+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

On Sun, Nov 30, 2025 at 01:03:39AM +0900, Koichiro Den wrote:
> Follow common kernel idioms for indices derived from configfs attributes
> and suppress Smatch warnings:
>
>   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
>   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
>
> Also fix the error message for out-of-range MW indices.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3ecc5059f92b..6c4c78915970 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -995,17 +995,18 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
>  	struct config_group *group = to_config_group(item);		\
>  	struct epf_ntb *ntb = to_epf_ntb(group);			\
>  	struct device *dev = &ntb->epf->dev;				\
> -	int win_no;							\
> +	int win_no, idx;						\
>  									\
>  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
>  		return -EINVAL;						\
>  									\
>  	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
>  		return -EINVAL;						\
>  	}								\
> -									\
> -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> +	idx = array_index_nospec(win_no - 1, ntb->num_mws);		\
> +	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\
>  }
>
>  #define EPF_NTB_MW_W(_name)						\
> @@ -1015,7 +1016,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	struct config_group *group = to_config_group(item);		\
>  	struct epf_ntb *ntb = to_epf_ntb(group);			\
>  	struct device *dev = &ntb->epf->dev;				\
> -	int win_no;							\
> +	int win_no, idx;						\
>  	u64 val;							\
>  	int ret;							\
>  									\
> @@ -1027,11 +1028,13 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  		return -EINVAL;						\
>  									\
>  	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
>  		return -EINVAL;						\
>  	}								\
>  									\
> -	ntb->mws_size[win_no - 1] = val;				\
> +	idx = array_index_nospec(win_no - 1, ntb->num_mws);		\
> +	ntb->mws_size[idx] = val;					\
>  									\
>  	return len;							\
>  }
> --
> 2.48.1
>

