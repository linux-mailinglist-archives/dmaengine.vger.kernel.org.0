Return-Path: <dmaengine+bounces-10749-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBu7JARtEGqgXAYAu9opvQ
	(envelope-from <dmaengine+bounces-10749-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:49:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED75B6767
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DFEC3064053
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B244CAF5;
	Fri, 22 May 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RLaPjBT0"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020082.outbound.protection.outlook.com [52.101.228.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A754218A4;
	Fri, 22 May 2026 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460902; cv=fail; b=J1cOVKoE5iStGiDPd4Rrte8NyRwwzirRP0ofK7H1jEjCcImmia7nmdNxabDA1TKCRF8ZYzMtNbvYnNwKGneXuYNJe5+w33eNFlZKo0caBz0fJWOQ/AVAgk25wcpEbJr/LUahk7TiKxW5B4+WgYThOz5OuNrYDKpSvSs+EtWX7/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460902; c=relaxed/simple;
	bh=evVfBDkWpDlfeCNks+J/HjGPwBe9oZR+W/RA2FVbU1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ysvij1VCrRrrtuToejFpZo3ADYP7YQqzi8wmyMuw7dHgeObrGQcCANW9dyS2dgFrGOPcZpfrTizr48rKAstpj69zJk5v0DgRobyhS+iIrcQBZzOWU2+68JX5HCfSS3Gfo309sgIwQ2Pqnh5d7XHFbxzC2fHv/UxDYO+O/yT9l28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RLaPjBT0; arc=fail smtp.client-ip=52.101.228.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXSBtEur9mtvEOL63AU2Z1vFGt5TKsmbBfurdPSK7jtFpOAkJ3HpX8E7gfe4VbQqdrZHbQvEnTt74CMagq3Pduvz/9HkQ6WXi7vMNl5nJ9PKRvq9CTYFR34qA5jdLbfNEQ1DnmjngW0OSO8Jd9FiVfAZYf3TMH9ZZ3G9OC/vHA+UjxUKe0LLPcARY4dRKmKL2eaMdhxyIQqeDDBFrs2J752vaG2G//pmdboErI+Ewpqm8IRfRJtVFaTnbXreGoWPmKCymHuPBmQCM3uKAefqgBf/nQk5ge2AQGIUqbD2yUr+J8SSiyrfOvNnjYAGIygWxw/K/odsto2EmvXd3avo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJrBqmEO01zAKI9VjjYfV9vc9eGNyDtlFUNqOdHMX7I=;
 b=grcLKI5EQdgAMlcXgfMjCiiQUnHi3YEF7zqR8MgtH+fVmLJrIbqPCS1qoXsmPxcke5qiuOOWqUHDmK5y1ZVu9pcOtr0kcumVA0UUfsfceRZf74VZ8L6s5W8ljNB8VTFZsqgcmItzQW17saXH5vRrIM0xkSJ1GaNrXaW6R14xVQEgWTgBdHVkS1Esd/bJ2ZcXDEYgCFsU4TUPq22Xg+kA7RkGbPqF+GuqsVE7gIWx5v77w0mkcQjCknnGlbKJXsiZHhx1ytBsNfoLyhZ2qF0vVD6Ub53Bdw1sfozb4bD2OeDDGCskIYIZ8doQniUWOLi/Dpw5uRrut7Gbf8YzU1EUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJrBqmEO01zAKI9VjjYfV9vc9eGNyDtlFUNqOdHMX7I=;
 b=RLaPjBT0v4WiZl7X4MvRh5wRy6s9UTYThv+ASTf0+Smxt4C+sbL74TKyxQP3T2IXx1cKpOx23w+CJKm+PUKzvJbljy+fdJkhKKAvvxy+IIG82Tb1qlwgoQUVsKf8Qrz4xdfLmhzqJgKoO4qoMxh5bQfb0RH9upcEA0x/+aKE++I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1773.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:41:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:41:39 +0000
Date: Fri, 22 May 2026 23:41:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] dmaengine: dw-edma-pcie: Rename DMA data copy
Message-ID: <dmzsvlp3d7ghdow6g4gpms7iopsm6vt4btzjz75etknkg6foqz@nyq76jwsi4ep>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-7-den@valinux.co.jp>
 <ag8ukeDKuw0h408_@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8ukeDKuw0h408_@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY6PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1773:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e0a049-a385-4b6d-e5ce-08deb8103bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|22082099003|56012099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eLCH1PDDyBSQl/mVRxYXcF2mte1SZH/t9XtIOiXpOIhH7w0RrgH+5bGAYN9ut0EPpbFpI/B2o1pZ9UPLxB7Fw1BTub8sa8vJPgm16nTATwhyOmVmey2h07sN4L3FGqRPuOKeHkcxfV3tiLnx5aYmdYVmLvHFna3+0MCYhsIrW2J2hfzKDeMdGKkZQ/L7fXUoo32nZNynLAzQfYKbgWzTz62UuMxU+qU9ng3ZE+zawzj2/7eQ2g9Dj3dg/UugmvTWLLvVKJFbTrUF1a4aU8H+uYoAfo8PI9GceUVMOPfDfEpyLtr50b1v6+hyFkHWApQbWPz8bCDcSRxHTQbfgaKdgO2O9ctfXC20bk7sRk23KYmTqpXQhlzXOpKq6LQXaipfBnCcD/ME4vzEiOTwDevcNpgbGXjof7Zag0L7YnwXBXvvWhyrQkRiqbjhedjihXbpS9qTitLcMKWuuMVnv9zoE9FBGTm0zUJeuxquOODpuozobSekcy1Tn+OPhYU4bbD+qoN7eWjZ7PDVB7KG/cn/v8LhqQvck44iD+hZhf+Ku8jjC4+qvs1mK+gz1uECGWL4AFQAIz/agIhT0hdJ8A0YJ6HrpFc1K2SnWz/aJsqN7hTKz4erKYt+LydUAc+OZakA27SMSM4Pqd1vkN2BhvgHodGv8u4UGM4kPpEJCK1oC3ywcKppapfS45z4JgANvYRr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sA6buiBJVWZIhNniGWzdyU/LGaJa6/Lv/yTKBnznGBX1QYSkQRjnQWvJ+JLO?=
 =?us-ascii?Q?MTm61TGAXb/E8fBxhgsDUInnhcX/3rY5xJ8nWOL35COl4taKn4msfoCHQUSW?=
 =?us-ascii?Q?UCaRIDZlWZRGzgQoDN6EGHwvi8xJHI/8dBAvVvFGFs9F9EmMt7Odq4Zb4QW0?=
 =?us-ascii?Q?qg81lWGGRy0feX5M84hEV2W3O1orS5YTh6GEtZs61NREn4Jd/TfL5Z5mnbNG?=
 =?us-ascii?Q?XYsDDEMMDm4kY7FVnRhkhcKAOswXanvAKySdpCm6OCwbkth5Zkx+ttBJNeBc?=
 =?us-ascii?Q?O2t5GWv49JMc2eaRKUcb3eTPF2FUhwdFa/gnpRCLzqT98ICVXfNQlEU/oUns?=
 =?us-ascii?Q?Owx978cOANIbUDfcy0CSVyFt4w74oZ9D/K42ppWWlbzWT5WWYypMOWsLn9aZ?=
 =?us-ascii?Q?qCtBJBf0r9rMRaLYwKe9DovE1JDhUNfrtR4GKiont9PwjVmjUVgW/sSo24vN?=
 =?us-ascii?Q?j367WDFGzT8OrW5ivFo/AQ+N44jbc50oxM1KznvUBRe85jpbF6SzBovoRnRr?=
 =?us-ascii?Q?ArC1ZHCboVy3GeAmOlGLaLmPRndQNlklSERoWvyuKZMGADirucApCjBeJdeH?=
 =?us-ascii?Q?uREdBt0V8jgyIUTPX64bhSVPfcDGv7HtJVLFrtT4UVIkLqp59YOwzaukpz4D?=
 =?us-ascii?Q?NSBZsvila1u07dNsWa/H7ByRS9cDRG4Osz4aEI6zYdcvlHVs0qKYPUff28Eh?=
 =?us-ascii?Q?C8Jjgh22ib14LU3GV2ZZ4s9CKYaBTRwf7leIVmihF69/two/x0hj8X7UQP4a?=
 =?us-ascii?Q?JTjDQpr0lg3CUQzd+CyFehW/DrF0fz6PUj+AueWeMv4RzaR8boEdRv5DD6DM?=
 =?us-ascii?Q?ueHCWRx3vcKMHO4yvw0iRUnZ2nczkpTe7HgbnrNuWbZ6Ljr8EprEgKNCdQzZ?=
 =?us-ascii?Q?d9QXOA3ysJqX4kOF1hAYaITyKUD3I1eXg6Onch5xuxUthrwqegtGO1NDZApw?=
 =?us-ascii?Q?mjkIM8ctGvjuUMsLgKBSyNr6p7nPBi3QiVwPiFrvyp0IZWl7hMTs+J+sqeRe?=
 =?us-ascii?Q?14XhCKers4q2CiYJMl09fHjvgUnnVAVZUJGUGO5h9btAzd5PQXahipbo3hnt?=
 =?us-ascii?Q?7gdu6NtRDizmft/1sidZNejRrVbYsCvEQwsE1sGMU9TDAk0a01cSK8vIz4Rn?=
 =?us-ascii?Q?Fn2Mr4NhwNO28y8hvDFeN2MLp/H7ADrV1ik/3J9Q1238fYyqnJfOQhqkJy90?=
 =?us-ascii?Q?3idod37//5lLAJJ5qK5s1nDU19VUwv6aGxzXemIK2IyXVLPdFt2ZB0WegXeF?=
 =?us-ascii?Q?Oc8wvRcT6+4bw0dm2x/UE2n7kqm4Y09Pla6OBVt0tKRb/86xc6L8cPq63Zpm?=
 =?us-ascii?Q?xVM6NsfwAyolQFBSKNGH8IAazdbTRdjSa599Q7DJdpx35s0CIFpVKJ27yXup?=
 =?us-ascii?Q?f6gCly6FT7wNSDUQEFjYjWWAjcDaUUuE970GhlafR47FR0L1JG/YoHgeFgMB?=
 =?us-ascii?Q?hWrZdpBz1IR3KJITCBj9IxBzw3OsyOF+4usQRcaVEMf8puz7YmUKpEGBGOLz?=
 =?us-ascii?Q?VmtOFVSFVOJ50vMu+94Ov/p9/31mvWcRGYYzTICbHTPVkihK4RG4l3Z1SJZR?=
 =?us-ascii?Q?sq2nJocWlIA/kNNHTnu3/gjmfGGitbA0UmOHN1lBjWgwRpArcbDME180H3Eo?=
 =?us-ascii?Q?BKklFuopvwQhqTsskLtQP8oLs/gyUB8E9QH7xIetCiDS1POI1iySnhUZJzcG?=
 =?us-ascii?Q?0lfjZcx7BWOm2RRgVytLlPTbYx7vwFQrbxNtvWiYINz0pdkk9LU9RSwNFrV0?=
 =?us-ascii?Q?ulVnOxDNuVUt/s+U9gHKDu8obmfeqwnLHgZVTT4S71sH2yqY0/aN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0a049-a385-4b6d-e5ce-08deb8103bac
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:41:39.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNTb43HYxE5GL9gLHvLruN+WckN3Zlki73rtpFewBAxZoetGco2u77vFDbQm9xTl6h/kYr6Z2Zpl3gH55Lr5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1773
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10749-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 09ED75B6767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:10:57PM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 03:31:09PM +0900, Koichiro Den wrote:
> 
> subject:
>     dmaengine: dw-edma-pcie: Rename vsec_data to dma_data

Thanks for the catch, I'll fix it.

Best regards,
Koichiro

> 
> > dw_edma_pcie_probe() now obtains DMA layout data through device-specific
> > capability callbacks, not only from PCIe Vendor-Specific Extended
> > Capabilities. Rename the local data copy from vsec_data to dma_data
> > before adding endpoint DMA BAR metadata discovery, which does not rely
> > on VSEC.
> >
> > No functional change intended.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Frank
> 

