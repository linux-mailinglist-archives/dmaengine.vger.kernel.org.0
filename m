Return-Path: <dmaengine+bounces-10044-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKNeG03l5WlkpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10044-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:35:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0442835C
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F02643004D92
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9833388E7C;
	Mon, 20 Apr 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SxBWG8bR"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E1388364;
	Mon, 20 Apr 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674107; cv=fail; b=dgUGAdyIvPzobpOLQac2UoYQUfkmoAJdYJBuudeh7C5BcEXLOKM0m9X72RxJ5gN5P5PAlwUoRInyiKvKBg12lOvg1o8yKBs70uFlvlUZ0NXF5xsEzBkDo5g+d2wcJQE9Yy1xC7tyFPb5eCwwMEGCNhYj5E4oS3bVsKMqpk3FBfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674107; c=relaxed/simple;
	bh=9Lr6ABOXkS5lFdPEAJp/VSW9kgMuAlaD6If/wiNotZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryJQBDEoaQlIUJl5ZaR5awZVy9BzVWstFPVp0AqAAq6LwXtvKUL+sVJVWT2jSNsO4Afi0G+h4o2HRkgzGqA98j9YsL0YuYYMuQYPH/MT8JuNs1XtHMxm1evHq0DUpl8CbR14ri07Q1/sbfgWHZUaqYlP2M9Mnzy/SZ6BIvIsKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SxBWG8bR; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdy8SQlYShsqap/AAPRxd2J58DaUTg/Ta4DrbXJd9RXaWBerkFep0VEGvw7CiFhyeT0XP9JLvkB092sHk+NJ6iMqLKcsnKpdf5fj8ytDesAkmo6G7rVdC8ixnkdnH0ioJnr8pB/5Yhfvn+re8XiqoC+2a/tEGuY8+iAItU/b2WVWnFOo73OVb6HgG63VKUKH4DvCP5VgXQde/lBWjiTbwzZnQXCZZSaU5y294SNR6rUyw+4wsBmMRedd0ahTmq59UlLzzMe33Wd0tgTxLkxCeXPawtr4C8CP+aeVhwU6TIQP1ZzDQcgmKrb13nUsyg7bDQRK2kOgLxT07RvU3P7WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5RwWtS6pr5ZjWL5ACfmp9tjRaESb09w3I7jG3DEMeU=;
 b=rNzkvYfYkjqI52ZSjnDpiuPpvq5MJgy0TdfkSt/8q+jIUL/wgE5tLJLLq6XdJwj8IfLaYN/QV5oxQ5lyB2Nu1baF1HfO2GnjD80FkPEGeJpR5Fwx/TqcH6ysF3MK/h5tokxcm8jFMzWHznF6i9p0GVQVAQqcf1iFXvi7iiRjjLzA57fLGm/AVO30llo2LxwAjTr94I+q/hzdjtSCfoopJHaNCM9686H/PgDdCun0S3nmTgBkJjynntv37yw38yAKQeZtfLJU+UDcIPqUtkZVMkG35Ii0D158lh2dvQv2AZKq7kllCIiDnkjhFrQnWfg5g5qp2o9Zt8DRUU/cCOkrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5RwWtS6pr5ZjWL5ACfmp9tjRaESb09w3I7jG3DEMeU=;
 b=SxBWG8bRF9AfU7zQZxQ6mVnyTT9VAHw0HDyK0p77U8jWUW4OOIHBrXHhjAKVeWSWOqLHNNyzOLoapuSjXtYL2pQyX7Z9XtF8bHvBG6tGFr0kL+amnEvZ2VWnGOfBwot2Zt/C99MFHn0I0EjwDGWkjRuU5PKUL6zorf0QJ8WEXo+RK+frm4tx7uz5XokVi8vNzSqGYjfwosSC7KdSHElFeZKv2GPtN+mUjdmLrZZJ7PNEfvlGP+GkggQU/th+ckgkiiXfku2FJCnVV/H7Hm6Kkn2LmI9TczL7FCTulNuXMvLUIfT2Hj6DuJW664TQrcV3eplkiOL4zcvrQkDP27YZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:35:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:35:03 +0000
Date: Mon, 20 Apr 2026 04:34:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 14/23] dmaengine: sdxi: Attach descriptor ring state to
 contexts
Message-ID: <aeXlMTenR8WGpBL2@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-14-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-14-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8d0810-f2f7-40e7-f327-08de9eb7b79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Yf4ek4vQQ4tNJz/XNWyZkZhD6+m5h44GOwOnYYXF4n3SNy5jBKWsxBkl2lRudRrIlt+2JPhhDJw3G4CCCFXGlvLBdOFqwDACkXjUNIWGvgfY7wGbQwOL1wEo8/olC1Nz/qW77sdFXu9hiKQD3yLAVzoQl5tE5DxhxHXy8t1V9F/72UY9CS/iZLq+2cpPvLA7YKfx5r0zrKImAc03zZHLXINufGWw85loYTURoff/EwoldIpZRb9yEGVM78e9ZAm8sJGU9jxtW9witR47NWx8gW/9WCeN10phcwuZ2vRUQ7CcNoERs2/QuhV2l/rPfWlFPfHZj+rpTxGTCf7Kp9PN1TZUVjBjcxeXMXhrxV31j8jZA0k/5GKYdV8g9g+Iod1HMOUy8JZzeF2rwquZWYU9PIWJY1e9AYtg9ynoNp6/YQEbFtD9/x6eZEB2rSY7jC2l0/gpWMGNxKYTlCuWOsQM1YRO0t63SFnywrhjkP6a18qe2EVc2V80JYbzbP6rJ/Fjy0NK+roFN+xCgn/0SfGCebVv3/qYYliQQkGnZ206HCkcXzv4SETigJ6InsMJDB4ZZi5IZKEPdFtKtVjDH3LI71ANEsWVtoe4qJ4ds0Up/tgawKJ+2zo34x5MGMiggILWBUH5+7aLGiLeGs9+DjlzGVRxHc13eIg2TD6kTCeh7Iy7F380Kw2UUrfuPLt8Y+h7S0eFt8xmGsDEv+eyrAXE1+FpXgEd5OiH1Pm/SbTBrHMk9dBP3Zv+TxE036ootdON7lnHlRE7CGK1YH9RGeH3mgiuLvB6KeOzzxpPUqh/fKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+Vd/Y24+CVyFHAYKc+kb77kdkEQrRnrSR3Um9je3dq2IfXwCSMLVzHQdtl+?=
 =?us-ascii?Q?pRuj2DA5Wl1kaBpamOjBpzOYJMtEeBkZTF350O09kmi3L7Zondr8uKpsLt7U?=
 =?us-ascii?Q?DKFhlWRBlAv1lbfmbLNLoXv+GU5RwoYIteGR1wuOoJTT9J4FJQf9raAwiZPS?=
 =?us-ascii?Q?/qYQ4l2mV8A2HLqWOnkG2RwAR2JwO8O/ucksI4iHQ4GGYl7ZfN2+qqCUTi5z?=
 =?us-ascii?Q?ManIOaH+71H/4HDkclhHNkt1XMPspqkvLcB56uHIRO1bPFBPRvOdMYfQwfLn?=
 =?us-ascii?Q?wd5Y+3GuvTtSaiABkQN8/76cfBVtmKFyKVztB0//4i/WneC89AyLEye0zKDU?=
 =?us-ascii?Q?wuE0X1sqAxCWcWO2JyCbDIWGwvl0A61KgB95oNZIIiqJktnziYQcYa6FzJQM?=
 =?us-ascii?Q?KyZvtcHnS67j1l0mtIfs69nTb8BpWDnGVaU58OoqyoHSMV6t51Qhk1oIEGcj?=
 =?us-ascii?Q?NtvZFOTggR0VTrIXZc26fXwwxzW5hTY1ncu5CuTVYShuei1401rYe1RRqm8L?=
 =?us-ascii?Q?2q0sXbph5RBolCJG4ZhYbQqdPOeIhwuS5nlnPd0fDdev1p0uu1sWjmbaCmpb?=
 =?us-ascii?Q?fG0XwrPJgTJ47LMHADmHhiQDs48M9uhCTqnYvqeqSpjoK9DvvUDUVY1cEuDd?=
 =?us-ascii?Q?GU1ZhDpgCu0Tj4oMXWrSfYusCkStFRsFhZ5k7PQMTyv06KHTHSNyjKHOqNx5?=
 =?us-ascii?Q?qvCnsg9/FwyjBgJFAuFSpvPVuDY3uNrfj/8FHCStSuBuq5osGswYY0CRORzW?=
 =?us-ascii?Q?pcTyILNE5F6XETYfyHeQAXbWiCURuZO5xFtT6WAqdZ2p/YT1cW3yRZdrafym?=
 =?us-ascii?Q?oBJUEJtqyD1NmMHALjgE2V7e4+Qi8W9gxg1ZNHSwGY4WaxGOti6rCedua4s4?=
 =?us-ascii?Q?jl0eWg5tWNEzax9uTNEL6lEAaSFFAxSMSXCu1jiUAIYCh8mr2tjXZzln3wkI?=
 =?us-ascii?Q?5Yi6E9Cd2Iq15gKq5XEifJtKob6MnxntnRB3NeGR5JTIPcTXnLdvKAfllpuJ?=
 =?us-ascii?Q?qeNpqvIPddk80GNk9BYrZf5hm53nkfT0GYk1KWO2rrfqOe780xPVsWClCeRy?=
 =?us-ascii?Q?2osN+ASSHKQeKREtqkDtP9BFp5GsXoIkZp+iUX+5KYCQoWbv2iEWuk0pcMIq?=
 =?us-ascii?Q?Lt5Nisw6cRPpOhNcYHjIAbHiHqZ0721ACTBzp+O7nVmuBPIl/c0Ze7bg8CWj?=
 =?us-ascii?Q?FJ0fj45mXf/I0jsZ/25kRr0+RyRAK4ci63YexhyqpKW264BZnixoRcuFlSId?=
 =?us-ascii?Q?GmFPyjTJ7diUvJSEan/jEQ4cTYrTtoUDz+6/QLyMObCLUIkqBDYxNxaBfz1v?=
 =?us-ascii?Q?apAer83zEQZAqJLqZTEyyTjPGNn71EVIeHCs1Wi0ZISCpHlmRd9deaXlS4hg?=
 =?us-ascii?Q?dkf+9xK+jyMnaGizErlOdtcdONFXqT9Ff3ZV5pX1kgaZytn45Iey0XEPLmQm?=
 =?us-ascii?Q?e0FrTaY1vmHwxEbc/EpgmZg1qr/6ANEfJHCM7AoYFvQkogEXJA8Kd0cCPeS+?=
 =?us-ascii?Q?KYk1T2wVWTBb+VVJZnN4g4tA961pLlm9/w06fgohKzFBC9+Ekbr3jNfUEaMK?=
 =?us-ascii?Q?rGpv/STmholFBRYwyDCIGxRl4XaPK50go3k5xnOiZusqfAPoUXwN1JDTeTIF?=
 =?us-ascii?Q?WOqmV60xuRIQKpa9GHO/+TAOJkw3Ge401teOxLfUsaTU2Z28zKWK9UbtmOqa?=
 =?us-ascii?Q?7lWxkvEL4mLim4vuUhrjdgxb9m7XCssizJ/V9E3VlD9AMm/voOWeMNMuR13C?=
 =?us-ascii?Q?8X7/OuPPAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8d0810-f2f7-40e7-f327-08de9eb7b79b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:35:03.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3D/qDhtbgylHZj3FdsaIElEJq3jlhELKE8YbNyXVG5Ie3JO0rFZ4+/kmhQycE4l3vlbsFhP6rfCQQ/XZvMu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10044-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: D3F0442835C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:24AM -0500, Nathan Lynch wrote:
> Attach an instance of struct sdxi_ring_state to each context upon
> allocation. Each ring state has the same lifetime has its context and
> is freed upon context release.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c | 13 +++++++++++++
>  drivers/dma/sdxi/context.h |  2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 7cae140c0a20..792b5032203b 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -24,6 +24,7 @@
>
>  #include "context.h"
>  #include "hw.h"
> +#include "ring.h"
>  #include "sdxi.h"
>
>  #define DEFAULT_DESC_RING_ENTRIES 1024
> @@ -60,6 +61,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi_to_dev(sdxi), sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }
>
> @@ -77,6 +79,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>
>  	cxt->sdxi = sdxi;
>
> +	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
> +	if (!cxt->ring_state)
> +		return NULL;
> +
>  	cxt->sq = kzalloc_obj(*cxt->sq, GFP_KERNEL);
>  	if (!cxt->sq)
>  		return NULL;
> @@ -373,6 +379,8 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	sq->cxt_sts->state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
>  	cxt->id = SDXI_ADMIN_CXT_ID;
>  	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
> +	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
> +			     sq->write_index, sq->ring_entries, sq->desc_ring);
>
>  	err = sdxi_publish_cxt(cxt);
>  	if (err)
> @@ -389,10 +397,15 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>   */
>  struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
>  {
> +	struct sdxi_sq *sq;
> +
>  	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
>  	if (!cxt)
>  		return NULL;
>
> +	sq = cxt->sq;
> +	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
> +			     sq->write_index, sq->ring_entries, sq->desc_ring);
>  	if (register_cxt(sdxi, cxt))
>  		return NULL;
>
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 5cd78e883c8d..9779b9aa4f86 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -54,6 +54,8 @@ struct sdxi_cxt {
>  	dma_addr_t akey_table_dma;
>
>  	struct sdxi_sq *sq;
> +
> +	struct sdxi_ring_state *ring_state;
>  };
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
>
> --
> 2.53.0
>

