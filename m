Return-Path: <dmaengine+bounces-6987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6BC07CA5
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973D03BA256
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BD348462;
	Fri, 24 Oct 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BNzIGJa/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB82F3613;
	Fri, 24 Oct 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331250; cv=fail; b=tLXxd1IKNt4RKhH0vRBR3gqAAVXYb8PYvI4ZT6QmvSTVExhjNSAcbWqwAebLdg86R6zvHXonreNcZdYlj+ge2KmF830DAo5E5l6mrdU4KfpSO8DFnyK5+dCs9CPdiIi50Q5MS8Xb7WEKWEAmOTFudVw0+k3kYCCG9UaDezY0v/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331250; c=relaxed/simple;
	bh=XZVkPXPko/UE3hm8tMgJT0EtdwubDkOsaOV6ArKj3vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDo9M6iB+t5qcAGODhDgOECsIUCM+P2jQQQQPuAlMQ8m0u2K1XBe06xUh1xf3XAHuX5kJU5kDXYJM9abh2FHc3azhthXTzKJ/DmYmf9ZcIO11ZT8HMSHcdBd5VrWMNvME/gruJnRpkE+clz3LzLLrVIHCGK1sdiCuyLIED97uUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BNzIGJa/; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYOfLZX9QVw3xhrkZwqaEy1lCj3QqdfkotNs2199L3uDCRGNmSrIiNPHRQVzSB6dID1d8zrL1KPC9Up3x2znhl4SjXhWWa6RyFkv1MOQSEzPMAM5dgS9GYHFqVkqfXg+4EnGPK0+KS5fk7e77k89+7EBQEeluyzUUGCCqVTDY9Ez0452QsMrfeF0ioifPFYPcaPvU/SOfmKJUTDOY1lrAPGkY/v91I54uMSLcljptzyineZEeErayDmsCjd9xIUgZyA+Ao90raKfXK0C4wmX41MvCsiyjxr2npaQEd8it4oxfFZd95gcyrUGoHsVwvU9bG153wI7HS6ImG5IOQ2nxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0/Qq/FMUAlbe+S0xugEvhmTBy017igHcmqsIstIv4w=;
 b=HmVv52fWzR6NDAyTafktTEZmTEPxoxClv7J69BfXiLTaGSznjN1VKNb8w5yLwxbzP93BO606VUtopP2wwkqJT7AeVzJTuEhFCx0g9UOdBQ/DpDoofgUhIPS+UAE26sSbfUZw7Mq2351gVcr+iSHFfE9NyxnVMYsS9XzyUZ76GkBhs6/I6ZrsuOXYsN9FiaBPQ92SkU2GAkWlz5bU4PxggrnWlfMLdPBct1+oImnCOWRchlUIDAu97nw0KvJXZq12Jd1txCo7XUILSVmv2ApQkm49GstjBzaw2n2qE13HlNXWga5QrrrguNieJxB2tNqhyYiCqQFg1mCPHcYT+WBbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0/Qq/FMUAlbe+S0xugEvhmTBy017igHcmqsIstIv4w=;
 b=BNzIGJa/PAdBMh6Zkj1X9aoCPA8t5Z6bkoR3b8otnq37V6GKV242qdCA+2mj2LSk8oVxAC9HZTaJQRhyvVdi8dBsu2xoisIDjOV5sBHshOln31N/iTX4DKhMfAhZM4aOla0SKx/Wwk/SFehSySkkS1DmnJKIl+fUNZfW/ay024OtDAqSI+7SF25bqRMDiQubfxvuhmEAA5S1ClFrLIcJH3TNZkxNGX+rboi+1RmeYOUCkvCkSGlTBBmIWDje1Sa7TvYs8J1fW//jGRlQIsYV/6rn5F940ll5XWxjLq+/0B56a0TqBeS1qXtATEpgmkhkh74+TZH1vnXDS9DAUF1TAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:40:44 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:40:43 +0000
Date: Fri, 24 Oct 2025 14:40:32 -0400
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
Subject: Re: [RFC PATCH 01/25] PCI: endpoint: pci-epf-vntb: Use
 array_index_nospec() on mws_size[] access
Message-ID: <aPvIIPHk0L4jSv9H@lizhi-Precision-Tower-5810>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <20251023071916.901355-2-den@valinux.co.jp>
 <aPrDEE80hSLbL57a@lizhi-Precision-Tower-5810>
 <iskqrcn6z2bnfnzrfc7kyy3x3ng7djn4ygral5cjtz3xiet4or@ktapppsfpzo7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iskqrcn6z2bnfnzrfc7kyy3x3ng7djn4ygral5cjtz3xiet4or@ktapppsfpzo7>
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb84bcc-27ba-4648-9690-08de132cd684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2SHMO//b3yE6KlDNJf3WJNVfeE9dIU2YIINCbuvfYD2MYHHEPK++2JRdR2n?=
 =?us-ascii?Q?5jt9ZoRTt0ObB4qaUtCeSzlTi1wwfEIkIgGQIvBX+Gl8UTa9UL3Yk+RZlcwL?=
 =?us-ascii?Q?uC/MxOgEVLq0yadXPEYfvQozkqYdBzRCdKG8BI76C/ZEOmJgAs/IF8G8QVbZ?=
 =?us-ascii?Q?tgcx+FfmTGZBJdYEEdi+0yC7BN4BOcu4JdOzw+J04Ml8HrPH8mAtE6dlQxUj?=
 =?us-ascii?Q?Hkwn48md9WlPl5yqACTTctA/AQLsqOu/D3Ltqd9V9gGijeAtIAE+hW2cDBzG?=
 =?us-ascii?Q?YM4uuEu+Zk7GZV9U45TDHs99sVdyfB7AXWNyrUHpVGOgUo56Y+cuePHAJO6k?=
 =?us-ascii?Q?8XNCaUBuCnq/tSuEfwXYEMy5txsAD1sc9mMxDNkPhoOS17TFV8naSsPHGU0n?=
 =?us-ascii?Q?8fvjPwzsJ2uZIpNf0/JK73N4ZRheiHPRBOFbKgLeolyXHAfZzX+m8EDL1jA+?=
 =?us-ascii?Q?G+rtiapM0eCoXvXLXWAJ6VbCDxE+q7VitAgi2+kR1Bw2JQWmBmH5lvUPaCUn?=
 =?us-ascii?Q?GSnAbxLAOKGhu/v1t4MPgnHOzwQO7wo2+6BFB7fK6CwrxSwUS0juNnmADlVg?=
 =?us-ascii?Q?SvOq0Q42xEy67qzypV4y50Bjz2hVdOHUPB7RGywlLWWCKreNH0btLaHSAcdm?=
 =?us-ascii?Q?HZFdPnyCKXt81T9VNsrs5tcQv2G0cFMFh9UOeVRziHZT5IBHXjIv+4Pnh6Y4?=
 =?us-ascii?Q?l+nvzkqA8wSjDVQWo5qbL3nIjhubFrfT7CRhWwX55RaZd667DvnpFdeEot+J?=
 =?us-ascii?Q?yOjN/fskuZDwFmc+1xnoZ8q31XihJSUVLBUS1HkcOCkM/kUKtel4I3E9HCn3?=
 =?us-ascii?Q?R3Wad8QsuwXIQgdtH6sYUhzs/V5XKRmrcWcY/fI8k0xljv3KTH2bMSY6Vyp+?=
 =?us-ascii?Q?iXAw2YJ66AaIxHBKPBJ1IX7KZUDwFpxBqTVRv5g7eQlfaY+2XsrR5YhEk7Xf?=
 =?us-ascii?Q?40U2sTC+EjqyRED3Jxn+QEuYW2sAqvluB01XZLHts2bUP/VgbrGnE+ZEobIQ?=
 =?us-ascii?Q?7GDKkusXiGuOXslHUnLBJ/aelACrM7CIVXcbopAypwh4TqooNGHbasZc/x68?=
 =?us-ascii?Q?I8MOa0dDR7L4EIytmZLqIgorbsoQEacSITPxgflo7SfOhTM8ygEtfoCBUY1L?=
 =?us-ascii?Q?5iNzuaFvUxVKk37JP5F8iJNb7hvm+no4QM/L9XlX5QjIpKppNmcELu2ErCYq?=
 =?us-ascii?Q?3CJjqsYdvyuMSzLxJBK4lQnmX9hV7X9dyRtefm731lLH0eXl2n7gm/77D2QO?=
 =?us-ascii?Q?tP1P3ezlRQTTv5kptoQNphUAU434qEmobW7rfiqPzK4tfUdX9Vjh679f4xAE?=
 =?us-ascii?Q?Dp8NQjtFQ1TQJGccv1fenvm5qV3tYOGeq+2Ew9Y0dxdK8pbHufRtJp6d1EtE?=
 =?us-ascii?Q?3XzySJBMJoX1Mk9ydmA8ALnA63vKtiuzoZa4OFc2yh3IbMnfgCjE+JkmwMZf?=
 =?us-ascii?Q?XVZRSk0z0tivvK94fA7c6R39Rmv5Jsr+2txt3Nj0fEWVlX8lmY13n/fAIVg/?=
 =?us-ascii?Q?WaREm/E+BtTAWpiXXxOELNGluSzOSkx0YRmk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDOAdw0GB/1Pne/yVYA3zlG1kIyqide1cmu3r8dh3W6BM8NsQ8A8bypGsuPB?=
 =?us-ascii?Q?RY68I54yyBkN4/sb4+APZSjc3nZcv2NDqbO94633uRBXv4UF7QVnz//iAsgv?=
 =?us-ascii?Q?2oQxBDXgkWdu9EB81hXMwYdK1hh3a8nrPNfeDvoBX3cwprEG6L3N8rj1pr5Y?=
 =?us-ascii?Q?EDRBWkfYDN3ok8F1O/ifiyKxzp1af/nFIX/ScJUbPd8AcEbMZ/UM4YToOdFT?=
 =?us-ascii?Q?spocLZ+80ajLWWwC9XP2jTKdmvjvCyJL2MZPmemi3BP1TyB7sdrJhq0Xl+LK?=
 =?us-ascii?Q?DLoHFnx6CNsuC1RvQd7tE+Z3z933uwLSlqNCC9dve7HGfxPdTYm7Ofl249TP?=
 =?us-ascii?Q?p84U59oNh+hZ8bGZ1n+XSuVXbWx0la9J9YUfr7GmPNC38ebGSmEP2GoiBfRN?=
 =?us-ascii?Q?woA/oAqO81j/HRG2XeqirwVoK2urSKrx65E26NBq7rp8rtnmM3+hwQRSJu6G?=
 =?us-ascii?Q?CIoD2FtnU+ya+0teuxMSfd0Ehrak0vFwK6KaL2fR5thhGUaT5gsJY83H6hpn?=
 =?us-ascii?Q?JJTmAbFxCcJ7swU2NoblXgN3tMZ5bkRc+r8Gd82YqbTbOL/I3zphjGWwLun0?=
 =?us-ascii?Q?6mQZPHEItUzxeOi8B9bp/CJwiU4aUsDohwqJE14MCmfeVC7kfZL169SjR9Mu?=
 =?us-ascii?Q?RmbGL1RX0z63o6BkyDkE/sUdKEzMX2JeM131J+cXyQytKL7M76wQ3XnstQku?=
 =?us-ascii?Q?m/2xUh+KvGpTSVAJwszAyH2uru/icBkjgNzCB8nBE6JcwHC6lpOAfmzYsk4l?=
 =?us-ascii?Q?CM7PWqL48m28R3sbrMmg5rhZP1Cg5dmCW+LYF3IQP0nbkHexW1E5jQGWitdq?=
 =?us-ascii?Q?loTv46MHxiUFV4fYJbZ8/jBQ/P8soIVxMqf8V0ICjQnSciEi7zPbrUsOAESB?=
 =?us-ascii?Q?ObRna+dzHE8QpvGnGen+uHGGYlHpKfXwngGDSOK/xU+PuL0utUVbSNGRkPC9?=
 =?us-ascii?Q?P7cNQe4mKkTz1bfgnOd4wm1Ueb0XL2QQYhLfCWFoIXyQsL4cK43bjZWeHnz1?=
 =?us-ascii?Q?YB8iqaNoj3LzOz6cRdRhPGMEomDgLmpvkZDnog4iv8THtHj5AymSZgvYMAlE?=
 =?us-ascii?Q?ATZBfJcuf904h3oq4Y11w4RMFiavmLBhXpgQW4F/2QoveNJoNqVuV71zXZrv?=
 =?us-ascii?Q?oxXYnz9fmc7NNWdYEepgdJuiIMes95m14UOA52kNtiFdS/j9ZKxYLsAokWtm?=
 =?us-ascii?Q?wIa9tSU+Z4IoBOU+/zzvAgIY5QtvWKV9HjSVdTTUXIvVnBTKeYzDU0vqT4dN?=
 =?us-ascii?Q?WRmMNWPOikKtF0OJjyhWSrcQHjS1aI9M5ffYXK8GhyGgON9csGBtCPpiR+EG?=
 =?us-ascii?Q?Wfza7Td7qulHag0YlLGcEhgwSlKkXsnb5+Yg0RKpAo7tbwZ+1CGocJZt2vbo?=
 =?us-ascii?Q?iecAzk/y3OGdkL+hboM9sZ1tuZEt3QQxX6NU85wqnLjydad+HXLFGC1GdQT3?=
 =?us-ascii?Q?XeydXaXLmwrnnA+jfGsF8S0UfC+5XK4PimOZIAWXY7Fqh3l980DB3V06EyQf?=
 =?us-ascii?Q?aVjYjwqDY8gYrX6CpN6M0Grfr2n0NkVMV/De8FKAXeyN+cPmr6ke6G/pb7kh?=
 =?us-ascii?Q?E7hEReBD5e3vh6yieuz87c7MCEp+49G6N3iogT53?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb84bcc-27ba-4648-9690-08de132cd684
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:40:43.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+QmM6wdNfLIGD3oeVLlOtC6SK6YQL3xHmk3IerucgcYnir/UuLnW1Ye24AIfTBw5LjNOfgn5Modj9+nGN7DDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

On Sat, Oct 25, 2025 at 01:24:29AM +0900, Koichiro Den wrote:
> On Thu, Oct 23, 2025 at 08:06:40PM -0400, Frank Li wrote:
> > On Thu, Oct 23, 2025 at 04:18:52PM +0900, Koichiro Den wrote:
> > > Follow common kernel idioms for indices derived from configfs attributes
> > > and suppress Smatch warnings:
> > >
> > >   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
> > >   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 23 +++++++++++--------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 83e9ab10f9c4..55307cd613c9 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> > >  	struct config_group *group = to_config_group(item);		\
> > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > >  	struct device *dev = &ntb->epf->dev;				\
> > > -	int win_no;							\
> > > +	int win_no, idx;						\
> > >  									\
> > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > >  		return -EINVAL;						\
> > >  									\
> > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > +	idx = win_no - 1;						\
> > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > +			win_no, ntb->num_mws);				\
> > >  		return -EINVAL;						\
> > >  	}								\
> > > -									\
> > > -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> > > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > > +	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\
> >
> > keep original check if (win_no <= 0 || win_no > ntb->num_mws)
> >
> > just
> > 	idx = array_index_nospec(win_no - 1, ntb->num_mws);
> > 	return sprintf(page, "%lld\n", ntb->mws_size[idx]);
> >
> > It should be more simple.
>
> Thanks for the review.
>
> For minimal changes, that makes sense. I'd also like to update the dev_err
> message (the "num_nws" typo, and I think what's invalid is win_no, not
> num_mws). So how about combining your suggestion with the log message
> update?

Okay!

Frank

>
> -Koichiro
>
> >
> > Frank
> > >  }
> > >
> > >  #define EPF_NTB_MW_W(_name)						\
> > > @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > >  	struct config_group *group = to_config_group(item);		\
> > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > >  	struct device *dev = &ntb->epf->dev;				\
> > > -	int win_no;							\
> > > +	int win_no, idx;						\
> > >  	u64 val;							\
> > >  	int ret;							\
> > >  									\
> > > @@ -907,12 +909,15 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > >  		return -EINVAL;						\
> > >  									\
> > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > +	idx = win_no - 1;						\
> > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > +			win_no, ntb->num_mws);				\
> > >  		return -EINVAL;						\
> > >  	}								\
> > >  									\
> > > -	ntb->mws_size[win_no - 1] = val;				\
> > > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > > +	ntb->mws_size[idx] = val;					\
> > >  									\
> > >  	return len;							\
> > >  }
> > > --
> > > 2.48.1
> > >

