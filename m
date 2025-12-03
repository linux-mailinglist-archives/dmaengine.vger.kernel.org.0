Return-Path: <dmaengine+bounces-7477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53DC9E383
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 09:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81143A9038
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21012D4807;
	Wed,  3 Dec 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HdP6WTBs"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011037.outbound.protection.outlook.com [40.107.74.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211D24DD09;
	Wed,  3 Dec 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750658; cv=fail; b=jTkhDA9l9AJl07EOIo5aVe04PUuBF8b0iiBIFyB8wrG9+vTeEJMrEY++EXyspE7R2Nbf9q9sUNY6QvSO/0OrQcTZACfwvi3TaKghU5CmsDyu5OVOSdMHyjjBi+O0avADFJvVr2kIIPCCi5jCdScQyH2nSylUIOWliXM9JsojPuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750658; c=relaxed/simple;
	bh=FZAjI7NWnhOAyBJG/vWFfJeUOv8smHZ/h/RB+iIIDY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h+HXtBy9jbfUuqW98I+Zr8UWpNbOSFohqPghVbjoXgsQxy34uFyOOKqqzV+UxLhkCuUmK4Q45V2PQVL+iXBojDd5P/Q4EcFaD0IfewDPcD7yDTT3s9FrpLFENmgz1UPtXbRx7+lMJtCC7Ad12BSgCC5c5AkmhDcnccn43Etun6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HdP6WTBs; arc=fail smtp.client-ip=40.107.74.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpIsWz1vvc5wHzB5RJu4EVA87TUkqyF2OJ6kSM+wIMKfMiSYOwKX10OtVuLDWm1srIObBt5M5RFIEee65qDQLVLSc/Jvuf7+Ns6FZ0we0GBKoWiqMXR9mi2ZX/qDsXuaxirp/tW0i9fp4ZQthSPrw832YFvGAkply1gKBOUUqk/s22qjumJHEyOKZaRMOBaY1lRpcvdQrO5ns9uA3o7ksGDYnZijKaMFFyAitjV3+ePRRM2vcETN5QfKdpN8so7rl3ER9GXeGzXhWq7bjvQzJhHnFuZgH2J/EZgFSuT9KhcVOECgaNboS1L2CGj3mHo9Nsy5BPynaSuBrsT+vW6ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTQ7VhZqdzngEC3wZOwpLJ/O8qCBV46QO4N7FkO8a3U=;
 b=xUs5fqWRa4Z7q8vKkSLq/XyM3kxkn40jzyAZ9M4l0Jg1a7XiI+gOrO/N80blNYuJCRnsJRkFG3X8oVffL1pFEJIk6SUQwPbDea6lWZ/TrBirzS9bHKEsHThNX8FkKIHMpBLCNqJVZTint3TUSx2MxDNImV9dMsnuU8gTGVigU2lTPI8PL2EAhAncuJDOobtcc1yQW4DG7IPaIj/9W4vgASJAB74+GlMDULjTPLWcTqWRKQizg7qhCvzeHsgnZ4hhpS3M9PoAuRbnVSpao8oiSwznRh3zoRR7koe+YKKDBKUyb+J2UaYuueiSD8ToXfDoRNjAHsGATvG93F5gxHPLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTQ7VhZqdzngEC3wZOwpLJ/O8qCBV46QO4N7FkO8a3U=;
 b=HdP6WTBsFGafSDedBM6lnHK4n6ZEVyzRCxRTt1QaWUEVtYLeVuzVY6QRV27J2l3xzZkkcVezW1picpz+A/pGPcyzUlDwbz0ruk3tsQMVreVWki9+F/jz1eJB7dH1u5SQXH/ZSJhAVdEjwsM9Qe9yl1CzqqiDVd1mWczGoq4mEoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4433.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 08:30:53 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:30:53 +0000
Date: Wed, 3 Dec 2025 17:30:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <mb2tkza65fj77i3cjs7t2lrcrxnlesn7aibf46zq3c3fahjp7i@2hcziakdeo5s>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS6H_6gBEQjmQUG0@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS6H_6gBEQjmQUG0@ryzen>
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e252b58-b332-44eb-a486-08de324645eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTlAAP31lvGwhsLSt8SvO7hDNjB6I9hLC2/Udgx2oQlcYfwHfsibGMMVX/Lf?=
 =?us-ascii?Q?uwvZMcroGQwhyTqfhfvt5sNzCAYncUhyWfv8ghaeUfdTOrv9DNKnTFGJkYJT?=
 =?us-ascii?Q?rpSGStCLtsPzGg/eOTXxs7m6DGpacX4b4Nk8hNq/XVIAIGkU2E55Tg3bGav2?=
 =?us-ascii?Q?gMDB/ZUWdoWIX9ywbEoeKXQ5f9Gyuh8ob1pI6ddI0W/VBOnVNf4cqAcdwFKq?=
 =?us-ascii?Q?M2iUoxa5trMKgjIrjXg3S1mvOVKyXpwkgPWNLcjLo2fvYTklef3Z65GwV0kD?=
 =?us-ascii?Q?tcP913AJ47hww6vO0lmjNzIFpbewTHEWwP/vWWliqxdYvgp630qLklX43Zmw?=
 =?us-ascii?Q?fhemucpg0Sw9UnJnbdd8PTqr99eofJgJrfYqdVlwqQKpkfRQzX75ecL2Ojom?=
 =?us-ascii?Q?0XAio/w8H4lwKi91N9/jibA/OJmTXkUjpzW/PqaAWgOPlBwklnk4UoA9h4cR?=
 =?us-ascii?Q?xjdYiVfAQfHqmX9gNiYwSrSkjwGwR71RfTZVilCcUIfdPVw7FCiQipFXfcX+?=
 =?us-ascii?Q?dBxmp+JRPFpHAzlj7V7R852wx6KG6zqc/gUC86NX6DTq3qXcm2s2mEQ4gH+D?=
 =?us-ascii?Q?4iu5ri9v1N4EVmcO5fEx5DMVJIqF7evgoh8lZ9Dy/oNAcYsOoE6i4piI2AS6?=
 =?us-ascii?Q?+hTh6/UfXL/U5VUaHGX1fHbwZE3MOBtyqmwIXTm7ksM4c7NFd0KQ552PlNw0?=
 =?us-ascii?Q?lsg9+hBHMgc35DVy0/y2O0806tYnmqHxIdva/oJIbp4Q6oe7QOhBeifCYgQa?=
 =?us-ascii?Q?icxFpv/xDp5rzPZXf1+E/ojPgJ3mTd/mqOTSIcfxWKgys8IprvglDJsRZfIq?=
 =?us-ascii?Q?WMVcZfpaSfTUyyAeHpce8q2aDXdJNARQrS4vjAptJziHj6ae4AvEmAF1KVG7?=
 =?us-ascii?Q?pUx3f0Bb99lnqa+Wg2p54bbg8pxvSS+GT6vu/xLj++G1nUy+XaJCkR2mXgUX?=
 =?us-ascii?Q?vXEuOGTN7CJIOng8mZgX48pcKrRfugYlmOkPcKW2DmaO3Cno6eRmpZ97s3/Y?=
 =?us-ascii?Q?0PnSrkqTez1uKTGAu6mPYr7Q67u0bk6pTyag8aqCGKgFKbkoTPmIc1JXUR6g?=
 =?us-ascii?Q?rBHMWlspfNZdpSLQK9wZwU56I/vOzLfH5Q8pDTpqSte2DmsQ2HU3vW/XN9Jf?=
 =?us-ascii?Q?0aN13medC90lF6U/js73UG6quxBl+HhvuiGHptolmQkfEsj/iCiuwQbt+91y?=
 =?us-ascii?Q?JfOCnsVYbfS03PmBSA4VrL3B1ibX4klC54fe5rH4CYksXAgyDw0ofF/n4ThN?=
 =?us-ascii?Q?gr70p9Vece6OrN4xeJcxUV3inlEnyj19CqS0O6rtTTr15eQSPkSR8N+0T5hT?=
 =?us-ascii?Q?zANlA+By/Nr/J5jW7JxAphSjIYq6khKSwdN7f3/uCPIaSfkN5+6VhuvMLyP+?=
 =?us-ascii?Q?IrvU/LRPf0aYvvice26Y1KSo9D2asz57KVx0ft6KHYBhwlIUOFjj9lQ6EeWu?=
 =?us-ascii?Q?XKbbO7CokmpOQuWVCxHtjjzAYrqLYAet?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNq9y1ptynbl8H8kzKHVJQpS1Hy6sJo3hmZl8KP0GXn7qyZfhnmnMQ/kJT05?=
 =?us-ascii?Q?5xLxkTg7S/HVyHXz6q+9AjIRExGyWo9qszBRb8mQmeUo+TqPNieRuqBiAUX5?=
 =?us-ascii?Q?h2+uBV9R2dOWXvp+jd9/XRGlTimkc/q5DVAG9mMh0ZYdxzXj6mj3GsjtinSs?=
 =?us-ascii?Q?hd7NNKSWKL87+9Z1z0Z9I18x3jQWo3iLrHw1yHbTK6eKDrykSPIX94lv1nmH?=
 =?us-ascii?Q?3YqEeh0/woWQF5vBKfsA/OkUOulrXCq/dofweFEM2EUzXXNEtYwxkdSGB8lt?=
 =?us-ascii?Q?A4tzL/RoZYaL4WJ/JeWmyPW5VCXK7FvBwIr5VkZD5UXKj7RyPgJysHrEMSdF?=
 =?us-ascii?Q?wJtCuAdBwPkl5fbCpS8BwN9X970hlxYNwQctXVjpodg7h78Xba9s/lqc4KFw?=
 =?us-ascii?Q?YBVc96jIeGfdpxTPaOi/Da991lPr5mswJeYaEG3R2W9WZDVCfqPs/QWdeU7C?=
 =?us-ascii?Q?x5jxYDFat8uULCx95BjtZ4Z1SUGLmw4Cl6yYtNa+DXOkDasvY2CnQhWnY7fi?=
 =?us-ascii?Q?P3Mbl4WDOTr1iQIvQVsr8RuHgj0KJptJv+QAykDhcSJy6uOUAVR1jy8tCEY2?=
 =?us-ascii?Q?2SuDMQfbEi3QGy3mmFajefhkDp04JI/4JWWWyZY2dbM5z4Vyv2NcaX7LApPU?=
 =?us-ascii?Q?aEUSjvChsfWG7O6b5uWh0j8YKcnV123/sShZeg+awk1lB5YXBCkKqjbjYQe9?=
 =?us-ascii?Q?zRkMXEMPdPSaluIo5cjcBJGjsxKhrCEDS4N3LLJ4tItcOMzJz50ZBDU4LIKw?=
 =?us-ascii?Q?DIHgcO0bAJjJSV6bvdJjG2aXSliFCreqVAiYZYNMvTXmujFHtOBzHfyDqWBm?=
 =?us-ascii?Q?NRfLtPYuHPAH7kk5aA6wgIOvc+Mp622dSEukFnzwie9KjZ3vrKzLKOZZDzLH?=
 =?us-ascii?Q?E4c5ENYIxqY/IrkixbDdVdaFZUv/3s0yrs87rCOiYznW19Xtd7TaRnb0qTiU?=
 =?us-ascii?Q?4PzJjbrf8NvlmhyZRGJiwUdIKPZFK4IoK3lSbza8ppTfLnk/BxELcrRUSvqR?=
 =?us-ascii?Q?H4vynDQSNQg7MCulLiStbbdVmlanRo5zCWrTlpaGF1UdCxHX2AOHWfJAgCRp?=
 =?us-ascii?Q?waweRFTFO9S+1KagaK0gpDrAMmlOJbeA1vugueb3JAgu5KsIiTD3bPTPuHcK?=
 =?us-ascii?Q?lOYA6/HeUGM4Ge0lR99vP1na3PygUVFhL4z7N0o758+67jVCwjbGDHGAydes?=
 =?us-ascii?Q?jreuGd4ZFsPwQbukYtuKDBPQFUnNAXfV1eQ/PdnZhJ9x5okyXXcgNhcsFzRW?=
 =?us-ascii?Q?+LM2gVAKwK5JerTB1M/8L7mtydzG4Br96Q9g9hEVgtmHEWJjnND5qjeq8v/I?=
 =?us-ascii?Q?p0ywfqoh/quuCqC5Ghylpk7sNPH7MD+ZzDOcCRGcOpbjO63sMKk/OqgpOQtr?=
 =?us-ascii?Q?xOyzuee/tp/TEDvIzCxp8TvLoa7FU9AeDbsJrtNZvZlnpEh95+UA48n/d21r?=
 =?us-ascii?Q?VLXgjexxba/jFWMrkPKrkyGgD/lXQcHcpqELvJBahMDf1LCYRG30hWVYItmQ?=
 =?us-ascii?Q?0yDjlsJD3x/2JPGSNCORiqQNZnI2UO1hzNmlo1uV3dQ2PvGmSFjNexfyQuTr?=
 =?us-ascii?Q?bnkrgkjlUAdPt97BHnDKL8qBDbBccstDMal0JTPy1MreX73y5pLsecS3YIBH?=
 =?us-ascii?Q?X5feBcbTjLU1Vd2xcYMXSjI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e252b58-b332-44eb-a486-08de324645eb
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:30:53.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifLRyTLw1eusg+tMSuPs9gsFKJxIx6Nr5iM+elwHI/2eAcTl7U2N8PgymWbhNGaVZ9EU9ThLqGArVJqMuOw1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4433

On Tue, Dec 02, 2025 at 07:32:31AM +0100, Niklas Cassel wrote:
> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > for the MSI target address on every interrupt and tears it down again
> > via dw_pcie_ep_unmap_addr().
> > 
> > On systems that heavily use the AXI bridge interface (for example when
> > the integrated eDMA engine is active), this means the outbound iATU
> > registers are updated while traffic is in flight. The DesignWare
> > endpoint spec warns that updating iATU registers in this situation is
> > not supported, and the behavior is undefined.
> 
> Please reference a specific section in the EP databook, and the specific
> EP databook version that you are using.

Ok, the section I was referring to in the commit message is:

DW EPC databook 5.40a - 3.10.6.1 iATU Outbound Programming Overview
"Caution: Dynamic iATU Programming with AXI Bridge Module You must not update
the iATU registers while operations are in progress on the AXI bridge slave
interface."

> 
> This patch appears to address quite a serious issue, so I think that you
> should submit it as a standalone patch, and not as part of a series.
> 
> (Especially not as part of an RFC which can take quite long before it is
> even submitted as a normal (non-RFC) series.)

Makes sense, thank you for the guidance.

Koichiro

> 
> 
> Kind regards,
> Niklas

