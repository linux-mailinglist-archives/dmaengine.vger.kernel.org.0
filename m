Return-Path: <dmaengine+bounces-8742-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLJoOpmMg2lWpAMAu9opvQ
	(envelope-from <dmaengine+bounces-8742-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 19:14:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD97EB832
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACFC305BBFE
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B243CEDB;
	Wed,  4 Feb 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hn1HcVxd"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6C43CEC6;
	Wed,  4 Feb 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228400; cv=fail; b=SmiIQAZCNgWKb0E5ejXi2yLh8zmRJzYMEyOkOs7A3YYQOUTELQTqRTpMKViYRuGg6q7SnJapqprs9vW4/P58tIbZF4wJm6riIHx+MLMWMmLlWcBCzDwK/a7LfCVFMkLdKLWTH+ek+caQauuJrkrUcD8SJ6n0Mqt0MN4ubaKnp+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228400; c=relaxed/simple;
	bh=RCPBhvvoiKMgaDMhz9YL88xXy6F9JwJDk3EIJyP2KSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qqEdPoiAhmwd8xo6atIyCAGWiyI9S6tHQt1g7mBjLTCpQjmBTDkpshVTFuov5y2rruVhqSPHOuvPfA2mio2bO05IDL/1Pv0k6R0eqbx8DGUa808RrjUSwX0h5gZYyMAwXxm2jMrAjsik7ZBswvLizWHjq0Wrmg4JwiYe6+0ilS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hn1HcVxd; arc=fail smtp.client-ip=52.101.83.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbgUzJBEh1v5FXJlxJ/wglbggChAqB/flV5fyOSNu/n+zi6Sm2cCMgDDZX0v0ibBQ4vezHwOL9/R/M4//wXBMhprvdNLPTk+MQOevAA2dX6pa8R06bQe/RkBulqCN/ZtEgviZ8nOKXvscjpwwa3k/sqpHA+ZNWVEiVxnfRF+lr3kKBCE4N3YfwWByNqwJ/HMjexBttbOS52rFF9mcjlj17UJtcxhs8ZM4pmh7C2IxitWApQjIvG5zflFfLxw9SE33xcvPencMBvCWz0Rn2X6YCZj1Ykl8s9HD9mo8DSDJxwAFX9Tul77jJ0BQwACEUXhuKKd2sJ0E9Q66a6HFSRGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlEI7kfIRxppsqgduwhTxMTOLrAUgdxj+ZSwdbdfDJI=;
 b=Jpq1s9GQg3DN2/P7v4k4WLO/NNFGJkTZRA4OUz3WOZj3GHR1MS9Q0cOxMgh1blrwlR/+q6pW3zvUbdA+VxMxKFvzsxv0vS7SWjSJtwKj6/ThNjOVrJL2T3DgM3msm+XATFAlr5IVvzV+PKBprfwnTHEiyVIDP68AmKW3awugPu84LrIsNhDmguX9ugmRiVyf2YOeVNSoaMpSJIX9+vjt8EDc2A87SEsSG7+u6PULzKSxyF7Q5RCbdBJGpmubQR+A4OtvFkg8tATGUfu6Aor8ksYL4R2RUKO+yLJASxJVzOZGVfDuxdkNENXhRBNarOKzT3dhUWzE09bGAmUj6NPOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlEI7kfIRxppsqgduwhTxMTOLrAUgdxj+ZSwdbdfDJI=;
 b=hn1HcVxdb/uWVrlZGWoTpAiOoPL65CIzAxdBAeeNdGPbW7sgBqnkSuocgwHqdSq2ZCwRFa94kpEg/eS/pE9sf6WxnRxImGZF+iR9rkh1w9VJa7WBRdeUhZIGXUeb8k7XY54FTXDdDsCT/IvEWy5FWcslF7JlaZvdv2QWg9Mwyauyq6yHbFw8YvxMwKAncZMbvis2uM9Un5z8UqcBhxTzHuJvYhsm79TWO9P5mucS3c632OjxBmg3NsKRckfX85E++QpdHTjXKCPJFIBwWyF6rlwSZQ60Nj/81QVe9tYZuvXv71DnHKpKEtB4eWsEz50bDi8vn2hvSlbx+9jlY2s7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11670.eurprd04.prod.outlook.com (2603:10a6:800:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:06:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 18:06:34 +0000
Date: Wed, 4 Feb 2026 13:06:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: dwc: ep: Report integrated DWC eDMA remote
 resources
Message-ID: <aYOKo1Ep9g9xxeQr@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-9-den@valinux.co.jp>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11670:EE_
X-MS-Office365-Filtering-Correlation-Id: 726ba26d-ac6e-4c37-188a-08de64182212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gV2wAQ0T19oxLTRupNN3xEWtzg+0mHgUW3LlHYWkv6AiqxdU1Mn207pM+XkP?=
 =?us-ascii?Q?pxEFHmViR1lsaTQUMbmd+xdyfD+1FI3Pv6F8Cz6K0SARvB2YWTYBrQXNi1Nn?=
 =?us-ascii?Q?xlNYgZyIzzgfq/jZVjhqgp8jSsAS+z+WHXh8J+GyacD5wDvTEgDEi/2wp/6v?=
 =?us-ascii?Q?PcteLTnR9iTEyFa2yVHKeF2gafZcyIURbGvcG55ez1H7Tvlb4h+y2KLnyNIP?=
 =?us-ascii?Q?f/dU+t0EZ8wtt3ZGMMz7tjyNh2Qj3Pc8TdzJO9rcZX87e5oyXab4yHIeETxZ?=
 =?us-ascii?Q?4/TB872E0FfJgM/j+ZzTlkK1KXc5QGjC+25jgI+u4MhqkfFNRsuxmtEaapFM?=
 =?us-ascii?Q?MMic/FIzOj34pbXRxySkIjFzMCkgl8m5jCNYVq12Y4dG+BdoT+3ezySct7Vo?=
 =?us-ascii?Q?tOaiQuJGSFIyr8m2Sqeky9OBW4oLbR8HxnU4N+yjooINCu1tjYBzGFXEWiRZ?=
 =?us-ascii?Q?j82N0o+B6Aerb2PrFOsW9migELgKXfXcbOuVrEps1Wbf/xg3pOSMT5M9CT6e?=
 =?us-ascii?Q?kFieHwcieMMIbPirqnx2VrVZM0PvsIzR1+uJZSx6dMMdvJB5V7znTNaDK1NW?=
 =?us-ascii?Q?6deEC2vvUwL0BUWtpbFv1sgZhqZgeBhit0SgWQnFd/3ifUtCCqN8YYXPnsN/?=
 =?us-ascii?Q?NlSa8DC40Mqs1gNo2FT0bM7YAEJ73tY7ADswfN40wY60bm+kGm8xLT9kmO97?=
 =?us-ascii?Q?l9vNyIqsfRsHe4UuAGqbHX1anGhKRDGnD962czhzVttg5oag9DXj7rQG5lV5?=
 =?us-ascii?Q?pFApI75YEZ/DYV96ppJ+g8O+mXPzDh3rd7azeUJJMKIsojkiaR/OCbugu+Nn?=
 =?us-ascii?Q?2FcvbH/er5kjGlz6LcoOCHO+lIBqo/9afa7iQJXGDnwyJV00NSiBUip2YTgL?=
 =?us-ascii?Q?y4B+88cU+YcqMNjZ9K5eYAH2ZUUZRlmmktAHxx37RLhpzWgu7Gdbrlda3Uhz?=
 =?us-ascii?Q?tO8LCUM/0vSONECRUAzEUCXkqx24WYHEeX6Ddl1+L/ur7D+sQcYPtGotrRXy?=
 =?us-ascii?Q?nVsKrLiR88WyTTFuY7Kvnw0/MC/i3EVDfQOXXCbMTVcIHd5PEhoBVyzUzrnA?=
 =?us-ascii?Q?/9V8dbQsImnNrKSrBr5kxrZE5WBG9jM7H4NgU6oW1SQMNvANAu3Ee7qFRVa7?=
 =?us-ascii?Q?MmEbOxRiQpxGh60Qap2SrQGL4HgrbHBZEHsMRWiL+1+94rwV1Qlq2aRP9rl3?=
 =?us-ascii?Q?cYVIu6c/0n3o5O5yCseytO0HX6OSS+C9Qm5D79OrS5IEFHxpWZCiyhUU8/+c?=
 =?us-ascii?Q?ztwa4gqvHqai2ndKxpa/aL+J48jtMQ6Xv2TM0DRm/7aEcLVl4iDhWtLdoLDj?=
 =?us-ascii?Q?P+uds1n3mU04arRV/GdnLF8Zio91FBC6GIhGhLUgRugQghuHHg6/zajBKmpE?=
 =?us-ascii?Q?X1OIsFU+64dKT7BDKJY+lQZvy3AAelzrFR92Ig3PyWQRWEDo01F8TgnYU5h7?=
 =?us-ascii?Q?ZdfcOMKdUFfFSnzYVSqovrAwREduHv2N542EMcIQUoEYZthEbvuF8EzofcGe?=
 =?us-ascii?Q?V8tVQlZZ9yL4vkXlvTBZtmEyo+lfSxqBH8mN7zUaviIqDZZeDu2RMbj7uBEr?=
 =?us-ascii?Q?85C4OEiaFzYDyOpIKEO90BL3zixl1ssdcBFQfj9fgYj7oCPOX5ej6vUbydD+?=
 =?us-ascii?Q?cOobJS0vUcQWSl3U+avdYss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qDw04uSp4Jh0R/GFRgQgFXLay/xkCOZQXoDs0RotNS8g2/++arJ09gsPOFT?=
 =?us-ascii?Q?AEmXeQ7BhzOTBzr1zZISQDPCQZXvqB8TmtHXzDuF5odty3QZc4jnUiPacjf8?=
 =?us-ascii?Q?YqsCXgyYUWxpqPSDS3PT9/E3pab3SwPJvw45IbebG00DZRL7v+qNuBg6kezo?=
 =?us-ascii?Q?wMkZ1SBm0qY8d78Y1Cr/WOwze1htJoN+1LD6D97kD3HS/8vhB8eVW/1e+T1C?=
 =?us-ascii?Q?oYSIYBdUQh24SknDzqJfUJwPW95jNinlvt5RqWb/7Ns20yOYFmoffhCdjAcZ?=
 =?us-ascii?Q?E6iUXST7eopP3pQ8AOkG4XdnsqMhteRF2sfwttGKQQ5h7soE3n9R8BlU68LC?=
 =?us-ascii?Q?7GvkUc01Ah9+C98fbgVoiFulQun1NuINoPzz+mt2AeTqnTEPRdhhp7skYNaM?=
 =?us-ascii?Q?7F1z+BAqVl2pl9RpjUxKJOJfjRKfVvscDzy+8OnhN4a5DmbmRxbOB9aYXLRq?=
 =?us-ascii?Q?EIuNLnK7CNzczNZpmTV+2vpxEXpYt8F89WevB5LJJpVdsHKE+JdROfdtnfG3?=
 =?us-ascii?Q?NdPQz8BbaKuWVW4CY/jOowq4AQgRgw62ccFqOnVu4ghpTZR6K0+sFgLZfSfR?=
 =?us-ascii?Q?2EvKYpHZF0wpfbbri3gcKxHFHSOd9Q/rn2sXU2C8y286tcVzXWbB6o9kjPtb?=
 =?us-ascii?Q?jy2UmwcrqoFABWkrhJ/kaLme5Z1ozR+eYNj+TNREpdXIUX6zmLVvWBhaR02J?=
 =?us-ascii?Q?/mtt8gWQRgJ7PSoPcd98nZ2JRJOpkVFxmYChyByY32zSkLAHPfoFdOPqKvxe?=
 =?us-ascii?Q?ghOKOnAAuLC4w1aDQh9xRzo06ewDsQqPc870gHFx/xI1TJWFveGISKNdCJgZ?=
 =?us-ascii?Q?j3ssjLOFvkh2rEDcM7L2O9HcdDzhiUwS5x32vmnhqlzBduH8sH1EfLL6TrG2?=
 =?us-ascii?Q?MMMjvk7mMmeArJVu1q+pvARMNu7BmRmgd6hS+bPrOH+MRRnnhCc8kx/1vsxy?=
 =?us-ascii?Q?sV54xOE1eHR8XVIR7zn8ZunA11W+rlwkocG/MSO4HW2TMI8AuNOkU8523K42?=
 =?us-ascii?Q?RAY0VSnCDUylxbFYdIMdrvEqNmMgKlcEElnYBO/sG4Js2dLeeFmI60ksHSJv?=
 =?us-ascii?Q?gkHHdkBb2XHV3WWOvtFZ9sFKUPH167f41ykZIjWa5KDOVbjWo4zoja1BrRdX?=
 =?us-ascii?Q?WWvNd5xKM8PtrW0nTMSqcLc36Bi/l1KrHq20vgHRJB397+EjgqPDs312AL4F?=
 =?us-ascii?Q?Iw82RNq9r6rEzcNkzxsBluz6aAfkUgKQLxd/XQ9OMjI0L87kRvCJHyeXAaUN?=
 =?us-ascii?Q?r/UE/3JWx5xzeadUQOEAMw4KeY9MLa75wOf8koqjLPxqAkqtHjLGmJhXH5vJ?=
 =?us-ascii?Q?MbPnuawXii5PDbK2ZTPWeWpvAptFrDnf6bWJOV0wMNdI3QYpv5pDexsAgVfL?=
 =?us-ascii?Q?o3cSBAMRwJpV/HdBWsftF68zTk3bMJWEZNkRnT/jD9OL62LPMPGV4OzWuuvu?=
 =?us-ascii?Q?g3e4SrvEBK0IhYWvGeV/dnYKpCNEw7CC2CNXiX4fDPKDx/Iy57Lj50+WDzgR?=
 =?us-ascii?Q?0JKLmOA836siR6X2gEftTuixBJ2yKOnZyT8H11OjbdsZVc8YTUZRxpI2nAUd?=
 =?us-ascii?Q?NSpxO6I2l6UVCthLut2BvsvFDZYfaSPxZ/6WPB3qCqSthWfXvhLQrImauvH4?=
 =?us-ascii?Q?6ipQqC4zF6x0XgX1yo9yET2AWwZEUKxzZjsarKUpcNLzF79v7hW2VbQkbQcJ?=
 =?us-ascii?Q?5gJeEr0S+DasT0zPWg440i3qsP/oed+uO75qD5C6hwU7W5zi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ba26d-ac6e-4c37-188a-08de64182212
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:06:34.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eAfrABoab5v7QchThu7EppQdhrBbZ4Mtv9KGnd8f+Orp58wsbJkCKb+lmWxjm3f1UTnd37n63yAZSC3bncJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8742-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5CD97EB832
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:36PM +0900, Koichiro Den wrote:
> Implement pci_epc_ops.get_remote_resources() for the DesignWare PCIe
> endpoint controller. Report:
> - the integrated eDMA control MMIO window
> - the per-channel linked-list regions for read/write engines
>
> This allows endpoint function drivers to discover and map or inform
> these resources to a remote peer using the generic EPC API.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..5c0dcbf18d07 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -808,6 +808,79 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	return ep->ops->get_features(ep);
>  }
>
> +static int
> +dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				struct pci_epc_remote_resource *resources,
> +				int num_resources)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_edma_chip *edma = &pci->edma;
> +	int ll_cnt = 0, needed, idx = 0;
> +	resource_size_t dma_size;
> +	phys_addr_t dma_phys;
> +	unsigned int i;
> +
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	dma_phys = pci->edma_reg_phys;
> +	dma_size = pci->edma_reg_size;
> +
> +	for (i = 0; i < edma->ll_wr_cnt; i++)
> +		if (edma->ll_region_wr[i].sz)
> +			ll_cnt++;
> +
> +	for (i = 0; i < edma->ll_rd_cnt; i++)
> +		if (edma->ll_region_rd[i].sz)
> +			ll_cnt++;
> +
> +	needed = 1 + ll_cnt;
> +
> +	/* Count query mode */
> +	if (!resources || !num_resources)
> +		return needed;
> +
> +	if (num_resources < needed)
> +		return -ENOSPC;

How to predict how many 'num_resources' needs?  provide
dw_pcie_ep_get_resource_number()?

Or dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                             struct pci_epc_remote_resource *resources,
                             int *num_resources)

return number_resource validate.  if resources is NULL, just return how
many resource needed.

Frank
> +
> +	resources[idx++] = (struct pci_epc_remote_resource) {
> +		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
> +		.phys_addr = dma_phys,
> +		.size = dma_size,
> +	};
> +
> +	/* One LL region per write channel */
> +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> +		if (!edma->ll_region_wr[i].sz)
> +			continue;
> +
> +		resources[idx++] = (struct pci_epc_remote_resource) {
> +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_wr[i].paddr,
> +			.size = edma->ll_region_wr[i].sz,
> +			.u.dma_chan_desc.hw_chan_id = i,
> +			.u.dma_chan_desc.ep2rc = true,
> +		};
> +	}
> +
> +	/* One LL region per read channel */
> +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> +		if (!edma->ll_region_rd[i].sz)
> +			continue;
> +
> +		resources[idx++] = (struct pci_epc_remote_resource) {
> +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_rd[i].paddr,
> +			.size = edma->ll_region_rd[i].sz,
> +			.u.dma_chan_desc.hw_chan_id = i,
> +			.u.dma_chan_desc.ep2rc = false,
> +		};
> +	}
> +
> +	return idx;
> +}
> +
>  static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
> @@ -823,6 +896,7 @@ static const struct pci_epc_ops epc_ops = {
>  	.start			= dw_pcie_ep_start,
>  	.stop			= dw_pcie_ep_stop,
>  	.get_features		= dw_pcie_ep_get_features,
> +	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
>  };
>
>  /**
> --
> 2.51.0
>

