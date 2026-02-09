Return-Path: <dmaengine+bounces-8848-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMHCMbkCimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8848-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:52:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D521122F5
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63D68300B5B9
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAC37C0F2;
	Mon,  9 Feb 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cytz7QqQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10B37D138;
	Mon,  9 Feb 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652331; cv=fail; b=qOkNN0sZt129ek4b2Rl4lD/8lpatyixfaYb7Z5In+lxZaVyGUWg/hBOjb4hU5u6ZzWsB6QQDJNQvI0YEWndGz1SMZuK5ULJh4BPBoE1XcFrWd8Qz4GQB2QACVk4i/iVGZR39SgfROh+H30diTx/Ck++rk3e7+LL3k0x00yt87Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652331; c=relaxed/simple;
	bh=v+UZfRKVbRp8kbjo+6zea7q3bqkEZFYlT0vlv06VurM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PIOYgukXMPQCx6nAmJiv8sXDDTpbLq8FGuedlKWxFKzcurB3NO8ceGXS3WMnnU93PiTIxcur0r+hvHiAHDvf1K7E4ADUQYbKJx6ilNHUH2UBdmzm74BnyXPo1FWXeEP+lQUdH4WsPRg0/HiPkHqc+s7COpDELEfbs/sZUypJag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cytz7QqQ; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV5bMeQIQWCBD9gpdiaoz91uLf5NUOE2PqkuUvWHJlxE/1mD5we8GMM/U0Eomicla+uqxlxggBkR20CbJsjynP8rlYRscdls6N7CO9xAYz6ho3fbW0YZb7mV3pLnndPjI2wgD7HP0TrHnZO4M2IwPI7E2aK85mgd9ufR5q6KK89H5hkx2vIErhYz3S7SBeHy0xyj/yi8Z75ycmx0Sl52x7XoDQAqw4hwl3Ns948/VcShTctIoy23zW3GWktNUZ44SgakVf5MAIjVoam3c5m9e3htsh1EWCsH4KOPivTqi1XhK529wCzbjZhEnhYH8xw+goprWkn/+nRfmYQ1ieXouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4JSSjdik5KtCou68JKHMNg5p3YnCmge8YYRhZCyJe0=;
 b=nwuPsKeYN4IE7Sxi6wp72eCgbYBaWkswJc3RRHcbOoxReuLpL6hoavvubCO6ldcY+SFoRN7CFX4p+GuYdM+vdYzDloMlhhs8YGafFN7rVd5Abpc8MrwcGcaP4PqPo7WcFMwa+MN56FRozfmAw3GkSZsazeh2PBDKODDvqBKNEolLXB6t2YRduMz31LHJDhJQxl/wLGvLAbZKYDahBHlHm9cpYubQpk1qYbm1wulQuhjeNiFaOmSox64l7RnhG1QuEeDqkc1q+W+yta45S/FVnRUNdTXSAtduNRZiCZWge4eBYb+aGfna3rJV8vNtLqzgv2Zn9Wmo0Rdh264G1/L6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4JSSjdik5KtCou68JKHMNg5p3YnCmge8YYRhZCyJe0=;
 b=cytz7QqQMAc1HNm64jpYnVPdqi0d9tSP9zACUUzJ3ip4PpqsXTlnbB1sw++JhSE4z3/g1Dc/XpKDljAGEeunI6sFEktEqxqxL8T33wROBQVAXYWz4XKc1zv5I3CujGv9Kd+4I58yuT2ZnA1/LP/V0G/j+hJp7YfbOVeU6UgjoVdV2Uleri02K6brX4OAuuwLTgub573jmxagBTHa7UVvWq8Zh5RERQvS684c9WP/5PMQ98uTwTQctiot3YW5w8X8rliipiUSzpAcoJ8EgUBst5NH7fRSfQ6OV6J01RXoaFXpXta5q0Ec7XgSYdVGq9uXSxXZHGxZHenvG5VM2S5MIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:52:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 15:52:07 +0000
Date: Mon, 9 Feb 2026 10:51:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aYoCnEmXYWA0f6TH@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-9-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: c77b67a5-5f2c-4a6d-fb7a-08de67f32dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KmSUUDbzXz7BLCws1X9Zvi9IrUzaFcByg0e2zTHXAFS/eXGDST5p6l4WScXt?=
 =?us-ascii?Q?cHaK38WL/ascKj4/7/ADZ3uUsGWC19NOpxJmXSVbvYX47ZUWK0qgQomhtqW0?=
 =?us-ascii?Q?Xf1NPSP4V8yW0VUZSBi7VkSBS32rIGTfZudXdJV2gw+WreOePC42K+nUnZyI?=
 =?us-ascii?Q?wCac83xwcZccudwa1pYrwAKetu8AkoeXy5TlhFHiekkEZni/CRS1cAwoNFAf?=
 =?us-ascii?Q?XOzVdVFKErIkFWk540IG0TIEEM8Jk4Qy6EskWjx15YjrSOy3JxVHqfxdI9tc?=
 =?us-ascii?Q?Pws3NO2pwMgER90uHbnDsnWAbe0rkWAda3j3GVyg0i7w6XERXlsFmvqvCTVh?=
 =?us-ascii?Q?csdqff4k1xuJwTSd6vxCf4TGAoLtOiBdcdYDpvqkozvWpMlqnjJ77nW7MjfW?=
 =?us-ascii?Q?zN2ncSsahUiuRCjzuqpWBuYHJT9yji+N8NGpev8mIxXMdhhog7NW1h7p6YI3?=
 =?us-ascii?Q?Ut5hq961pAANEoo2lXE5mPKUThnOxe9YrzTT9pumUzvIsyKJbD86QhX44p5B?=
 =?us-ascii?Q?BvhNJKAXeN65OpU5MORZ92Fncii9Q1xFWxTrLvHeLk7rEsgHuL0aZVUfA2Ts?=
 =?us-ascii?Q?QfhMVJL0oXq0UizNkmEy6M1F7wdVv0KfbtZbeMrpriNARcTcoOcfR+dcasW9?=
 =?us-ascii?Q?UDPjBp0CkbYCsTl7LRqeehf+dR8ptvFA2L3jbk13haF81M+dDFym1iUzYcgW?=
 =?us-ascii?Q?6rllSZLT1BtEWfGdWmYXF6Hc+njhPvgLXbAtmRv9lMf3iK5+9UWV1bj8ztGs?=
 =?us-ascii?Q?zUjCXwcjZ/tIXGRdfktdGagW0Z5gxDnct5BHts1DiSJvBetEimfIanlLf36U?=
 =?us-ascii?Q?hOXUQtwTPhqF7UgnDS1tY3gXJNbKmlKHKLChEC9C0yOIqwPewk7OfRQg5HP8?=
 =?us-ascii?Q?CKcRCpUGGT9RJFhF/inbw4f3+/eKRjMgNefZngiw9N8f06+4pV9beFLljWso?=
 =?us-ascii?Q?840FSvSgcu/xGaib7l67bdUT6ocZHv3uaUH8Zqt8smQtzPg+FL8tDI4bidKp?=
 =?us-ascii?Q?K2kcMx9tbXnM7g8R/THDQNUE+v4Gal/QkO55b/PprcOCn7RSv3IAgu65EvZa?=
 =?us-ascii?Q?Oqo/wVcF8lkrTj+41jitH1sojlwMOGgss7xGVY6FLjxY/mf4rjqd/6DpOYyP?=
 =?us-ascii?Q?xkyNwv3Xfkj3pJjgZCJM497oQADHIbQractPrkU2nU/5Q0D6lPkzW3Z0RnEV?=
 =?us-ascii?Q?zaHGf55OIlwT9xPgCnaidtLRQwf/YrDDtKvs2WcaUaemPXSQs83qaXTFfCmj?=
 =?us-ascii?Q?VLkmVjAMeRWSDEPTc15+aptJ05nbc+GkM0VFzW7LfPFDnBRwzqc2jirmGb9g?=
 =?us-ascii?Q?MKtHPVUvk9g9+nwhGc4iBg+o5J10r/zRhGtmVgAzE/YwDvjYBMDjYFxW76Gt?=
 =?us-ascii?Q?IVVPBVQxafsKw9V32quzGx89+BjaWUxYPty0v1N4h/phdUj9I35Fn6TBdPEr?=
 =?us-ascii?Q?KfTW3hm9jR3qUmwEtbm6+tDmfrwqG/GNZO+soJJ+4o1/LS+sdi7DaYV9UwaB?=
 =?us-ascii?Q?gzuJppxeXz1T6Hs6H/uJk1r6pb0YeiBY66Ki5Er4HLKLK3xF8pkpCDlPaKK7?=
 =?us-ascii?Q?NN13dUqgNiTTx9DTZNuXTg9ogP1FNryrS78uO4zFMUjfzV0bZrczy1QB0N9o?=
 =?us-ascii?Q?8ms5Vm6QFihJATyKUTqqo+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50sUlFC99LNHGWceU1Z9Ti5hWTqPCaizHxi+oafKpd2j3efnnQbpiDk7MyU1?=
 =?us-ascii?Q?FYWTfUKnKLKtK8Ni/fA2WoPAqNcjLBZFv+O1U1ASj42mQV3iCKz0NVKfLTVC?=
 =?us-ascii?Q?ZjQWrkKL5KcTf/Eqa/COVwfpKc06R9xrW5CHXzoGiHrgTYRApG0gxG7waqQy?=
 =?us-ascii?Q?qX6DAH2G3teK7a+Y6Bve7Jcvpc4sw/E5YNzMFsmnD298DRwDWAMkeG7lSV1P?=
 =?us-ascii?Q?8AKI4Npu2BdCAAj3sO1KsmSUIsuvUw7wdGPMCSm+Og2CSVIOSkPJfQq3VK+8?=
 =?us-ascii?Q?vX5pFYS7sHgrt0J+2mIhU0xHypAxLPDiQb+4j/lj4ryM0XONXpfTHosSP4P0?=
 =?us-ascii?Q?vxCYihhhChVfFyR0JZzpYWDlQxF7Pt+LE3IV1vAmdJLI3Gc1HcfQMt9iccMq?=
 =?us-ascii?Q?vqzdyvl6H50kDlsH/5veWBkV3tNWOHVM2SeI5ShQ0bLXt6ytxS3izFJ6ocUc?=
 =?us-ascii?Q?GH2ZsFBmDnkihZyGF5KCBIj8+8DrfgCqkz5sNUqRH5LY3K6AdWrlhNqgg1wW?=
 =?us-ascii?Q?yfndJH/2mrCUJWjvz5aW+WGZovehEQ45QgW4p5ry0ovk3qeBZvcXRdm49QYZ?=
 =?us-ascii?Q?chqeoyv7+eqe1UjLosRK4Lrq8GMm0g81QfHOhZcIbGXa66IoMIiQj4nf/omH?=
 =?us-ascii?Q?+tpt7LDV1s1aWWD3+HQH9pwdy5zOHtYsu4xX4em54ldPKgGV6bfhD3YtoBGI?=
 =?us-ascii?Q?j6jFXBrgpwvOO8wWpBxarKtJWTHq9h8IENpgy1uGF9NWTYBlfRM7Oex8EvRI?=
 =?us-ascii?Q?kb96CGo7Sp1kuq5wrMNjm7LbdfR9IpNtrbs2nsoNvtIiVAB8O0kxm0GE22In?=
 =?us-ascii?Q?um9eXfdRDecxRu4r6S/lucyWaEc9zKMsuk98VYGleZb184hV6A2HaWbfbl9d?=
 =?us-ascii?Q?scsjT76xdWl1/3CPe4HxHuCyZoMq1o9zYWnPqdVzNIouoBTscwZC7tmBoUpX?=
 =?us-ascii?Q?sCNj0qNOEk1T9jWrjb3JfiNEW+jfbxZSckTMdOsVpAyOLGox8/3LPjEksE6K?=
 =?us-ascii?Q?tIm3pGTW5M6wy07hjY0pL0JcRtMP4lU+dYzkLS90PrsyrvUTqHqCauwoxq0o?=
 =?us-ascii?Q?wLGcCK1UyAGFLwewippDeJhaEGHfwHMyXgMtGfyd0cZlQ+JPDcM33GdczHqM?=
 =?us-ascii?Q?DxxIUlnI+JLBp4FsM+4aOSlgy1ZDNlzlj6ml7I+RaFTMjZ6tJsRthPCpl4mC?=
 =?us-ascii?Q?PHk3EdRglJ89VeZu3Kea7jihhWwSyUgbJe+MCrdfmWMrZCL5+zCANkBoiPf4?=
 =?us-ascii?Q?VQ+46sd3P5GP9roC6p3Y97exeStz5Eo0V32UNgRowAynBtREUkdZk7DIV7Yl?=
 =?us-ascii?Q?HFNoF5KjAEajsV3g6rPXpnryzyh9I4tCE07eKEzwQG8nwRAq7U1EQqyNRLpH?=
 =?us-ascii?Q?vgHiksCsK3y9N48vCl5JoQhAjUB1qk054fL2O3sMHJ5nxgc6jSh1/Gg1hCUr?=
 =?us-ascii?Q?kbpig5aqXYfhNpeZMtgq4+NnWn9Ur7MAN+iWlsW86JHju7PKXNp/W6OrryY+?=
 =?us-ascii?Q?r6YQMahUmnAktxnwxra16T7tZvpKsRaVURrcS3qyAJ3sYPKuHV5jlYZQR5hX?=
 =?us-ascii?Q?zwnm7DfszK8RRfDQaNoVFpzUTpozTs9LiQhwA563owIqJvxiJ879uOsfyvxv?=
 =?us-ascii?Q?x/8syHMlIH5dS0/jGNh7zU4AnKJaB1c8D4yVz8HtNhqLlZBxahH/m+soadlg?=
 =?us-ascii?Q?g9fSK/UhF1OW5FEdk5P72EG0ycV31JV9g1av6NDQlveck+nw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77b67a5-5f2c-4a6d-fb7a-08de67f32dad
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:52:07.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZlc0TjNi0rSzO+GSJ5T24C9Ma86vjDIpYs8PvGcGNghqbcTkYxnfKaIQM4FTGS+IceIRbiKgnkAJcU38JWZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8848-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 66D521122F5
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:16PM +0900, Koichiro Den wrote:
> pci_epf_alloc_doorbell() currently allocates MSI-backed doorbells using
> the MSI domain returned by of_msi_map_get_device_domain(...,
> DOMAIN_BUS_PLATFORM_MSI). On platforms where such an MSI irq domain is
> not available, EPF drivers cannot provide doorbells to the RC. Even if
> it's available and MSI device domain successfully created, the write
> into the message address via BAR inbound mapping might not work for
> platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
> mapping does not reach ITS at least on R-Car Gen4 Spider).
>
> Add an "embedded (DMA) doorbell" fallback path that uses EPC-provided
> auxiliary resources to build doorbell address/data pairs backed by a
> platform device MMIO region (e.g. dw-edma) and a shared platform IRQ.
>
> To let EPF drivers request interrupts correctly, extend struct
> pci_epf_doorbell_msg with the doorbell type and required IRQ request
> flags. Update pci-epf-test to handle shared IRQ constraints by using a
> trivial primary handler to wake the threaded handler, and update
> pci-epf-vntb to use the required irq_flags.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  29 +++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
>  drivers/pci/endpoint/pci-ep-msi.c             | 129 ++++++++++++++++--
>  include/linux/pci-epf.h                       |  17 ++-
>  4 files changed, 160 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 23034f548c90..2f3b2e6a3e29 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -711,6 +711,26 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>
> +/*
> + * Embedded doorbell fallback uses a platform IRQ which is already owned by a
> + * platform driver (e.g. dw-edma) and therefore must be requested IRQF_SHARED.
> + * We cannot add IRQF_ONESHOT here because shared IRQ handlers must agree on
> + * IRQF_ONESHOT.
> + *
> + * request_threaded_irq() with handler == NULL would be rejected for !ONESHOT
> + * because the default primary handler only wakes the thread and does not
> + * mask/ack the interrupt, which can livelock on level-triggered IRQs.
> + *
> + * In the embedded doorbell fallback, the IRQ owner is responsible for
> + * acknowledging/deasserting the interrupt source in hardirq context before the
> + * IRQ line is unmasked. Therefore this driver only needs a trivial primary
> + * handler to wake the threaded handler.
> + */
> +static irqreturn_t pci_epf_test_doorbell_primary(int irq, void *data)
> +{
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  {
>  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> @@ -731,6 +751,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
>  	struct pci_epc *epc = epf->epc;
> +	unsigned long irq_flags;
>  	struct msi_msg *msg;
>  	enum pci_barno bar;
>  	size_t offset;
> @@ -745,10 +766,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>
> +	irq_flags = epf->db_msg[0].irq_flags;
> +	if (!(irq_flags & IRQF_SHARED))
> +		irq_flags |= IRQF_ONESHOT;
>  	epf_test->db_irq_requested = false;
>
> -	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> +	ret = request_threaded_irq(epf->db_msg[0].virq,
> +				   pci_epf_test_doorbell_primary,
> +				   pci_epf_test_doorbell_handler, irq_flags,
>  				   "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3ecc5059f92b..d2fd1e194088 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -535,7 +535,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>
>  	for (i = 0; i < ntb->db_count; i++) {
>  		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> -				  0, "pci_epf_vntb_db", ntb);
> +				  epf->db_msg[i].irq_flags, "pci_epf_vntb_db",
> +				  ntb);
>
>  		if (ret) {
>  			dev_err(&epf->dev,
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index ad8a81d6ad77..0e93d4789abd 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> @@ -35,23 +36,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>
> -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epc *epc = epf->epc;
> -	struct device *dev = &epf->dev;
> -	struct irq_domain *domain;
> -	void *msg;
> -	int ret;
> -	int i;
> +	const struct pci_epc_aux_resource *dma_ctrl = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	int count, ret, i, db;
>
> -	/* TODO: Multi-EPF support */
> -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> -		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> -		return -EINVAL;
> +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					  NULL, 0);
> +	if (count == -EOPNOTSUPP || count == 0)
> +		return -ENODEV;
> +	if (count < 0)
> +		return count;
> +
> +	struct pci_epc_aux_resource *res __free(kfree) =
> +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					res, count);
> +	if (ret == -EOPNOTSUPP || ret == 0)
> +		return -ENODEV;
> +	if (ret < 0)
> +		return ret;
> +
> +	count = ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (res[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO) {

I suggest use PCI_EPC_EMBEDED_DOORBELL_MMIO directly because some vendor
have really doorbell register space.

below addr is that phys_addr + res[i].u.dma_chan_desc.db_offset. So vendor
can easily change to their doorbell register space in future.

Frank

> +			dma_ctrl = &res[i];
> +			break;
> +		}
> +	}
> +	if (!dma_ctrl)
> +		return -ENODEV;
> +
> +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	for (i = 0, db = 0; i < count && db < num_db; i++) {
> +		u64 addr;
> +
> +		if (res[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
> +			continue;
> +
> +		if (res[i].u.dma_chan_desc.db_offset >= dma_ctrl->size)
> +			continue;
> +
> +		addr = (u64)dma_ctrl->phys_addr + res[i].u.dma_chan_desc.db_offset;
> +
> +		msg[db].msg.address_lo = (u32)addr;
> +		msg[db].msg.address_hi = (u32)(addr >> 32);
> +		msg[db].msg.data = 0;
> +		msg[db].virq = res[i].u.dma_chan_desc.irq;
> +		msg[db].irq_flags = IRQF_SHARED;
> +		msg[db].type = PCI_EPF_DOORBELL_EMBEDDED;
> +		db++;
>  	}
>
> -	if (epf->db_msg)
> -		return -EBUSY;
> +	if (db != num_db) {
> +		kfree(msg);
> +		return -ENOSPC;
> +	}
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +	return 0;
> +}
> +
> +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
> +{

suggest create patch, which only add helper function
pci_epf_alloc_doorbell_msi().

Then add pci_epf_alloc_doorbell_embedded.

Frank
> +	struct pci_epf_doorbell_msg *msg;
> +	struct device *dev = &epf->dev;
> +	struct pci_epc *epc = epf->epc;
> +	struct irq_domain *domain;
> +	int ret, i;
>
>  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
>  					      DOMAIN_BUS_PLATFORM_MSI);
> @@ -74,6 +136,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!msg)
>  		return -ENOMEM;
>
> +	for (i = 0; i < num_db; i++) {
> +		msg[i].irq_flags = 0;
> +		msg[i].type = PCI_EPF_DOORBELL_MSI;
> +	}
> +
>  	epf->num_db = num_db;
>  	epf->db_msg = msg;
>
> @@ -90,13 +157,49 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	for (i = 0; i < num_db; i++)
>  		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
>
> +	return 0;
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int ret;
> +
> +	/* TODO: Multi-EPF support */
> +	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> +		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epf->db_msg)
> +		return -EBUSY;
> +
> +	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> +	if (!ret)
> +		return 0;
> +
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> +	if (!ret) {
> +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> +		return 0;
> +	}
> +
> +	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>
>  void pci_epf_free_doorbell(struct pci_epf *epf)
>  {
> -	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> +	if (!epf->db_msg)
> +		return;
> +
> +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> +		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
>
>  	kfree(epf->db_msg);
>  	epf->db_msg = NULL;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 7737a7c03260..e6625198f401 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -152,14 +152,27 @@ struct pci_epf_bar {
>  	struct pci_epf_bar_submap	*submap;
>  };
>
> +enum pci_epf_doorbell_type {
> +	PCI_EPF_DOORBELL_MSI = 0,
> +	PCI_EPF_DOORBELL_EMBEDDED,
> +};
> +
>  /**
>   * struct pci_epf_doorbell_msg - represents doorbell message
> - * @msg: MSI message
> - * @virq: IRQ number of this doorbell MSI message
> + * @msg: Doorbell address/data pair to be mapped into BAR space.
> + *       For MSI-backed doorbells this is the MSI message, while for
> + *       "embedded" doorbells this represents an MMIO write that asserts
> + *       an interrupt on the EP side.
> + * @virq: IRQ number of this doorbell message
> + * @irq_flags: Required flags for request_irq()/request_threaded_irq().
> + *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
> + * @type: Doorbell type.
>   */
>  struct pci_epf_doorbell_msg {
>  	struct msi_msg msg;
>  	int virq;
> +	unsigned long irq_flags;
> +	enum pci_epf_doorbell_type type;
>  };
>
>  /**
> --
> 2.51.0
>

