Return-Path: <dmaengine+bounces-8628-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO2DOM7XfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8628-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 17:09:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454BBC66A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 17:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8295330071D1
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5C340A69;
	Fri, 30 Jan 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mia80neT"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125432690EC;
	Fri, 30 Jan 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789303; cv=fail; b=nkIaX9+V9TozSBulrEwz9Kw4pVwcrr5rJQFbkb0x0nt0ALv/fLaYEVKXMD438lBfkqyy4ffs/mkdjSWOnG/nIIQDuCa6wa6f5hSCv5iKMPCLzO+1mTVQw+tYnT5obgbjRP0I6WlLjkk5qqBoFxIexLNZsKYxl+97ebGz4DRsDz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789303; c=relaxed/simple;
	bh=z50uOzU5b8ySXm72RcmRPt8y0Qemoy5nuX3QcC6fy/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8efoMeZnDKKiz6h1Dn8XiclfeeXmvlBttqmjh6kShAnZqDVVZ15iHHIA1xeT4J/WC1LzUGFCNWDcRcrRFLCFAlT0VywrXpnIt55KXzzeH72AlQQpX6Lc8+0xpS7XEp38nz3v/b6ul/NP2VPBaNn8Dq8Mq6i6V2qDH0cyvA2zlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mia80neT; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONE8v3H52uEkH56i8/dko0hiLtOZznqL8r+1gXZUHTZ9VCqiwxXAjYBhInyyRilFkuQ0gDtcmjBNKM3STQhUnmdY6CDgQIJ5WLd/xGmmPisrJmbwzVCM2KLbrpem83AQr+FOLaMc2Tm+C0JT+O/kXp2hRuT4dqxBx9L+r1Bs9Uuy/aYBwLZLYNl3v+Vsvdv24mDI3AoqAMg7O5/tFeFXpeeDLNFAatBn8DqqrS8Iv6LbPVUmDnb9FJ86Xt3Lk6A2Go4OY7GWGyos2+02oxTe1sOdEm71qQ9hVA52Q00d2Naqaj7Einhewr1iBxXFrJLXwoAVqqnwkgrSQ0ALpxWhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuB5AmuQMIWHOyEQI/6Bx4+efmjuibLIYHDg2+ZEQlk=;
 b=pzvqFra0TXHbfWI4TNu4kUgDgqBhkRdeWC21l95x/M6nPnpXYxvbSLp42s0+Q12LsPoTKZbWYqxgllgfKGh4pqgYtK0zfdhirehzKXLEHAnrIoJW6LHRLw03GGhJ8laesliKMtrwZAoDJcv0X75Gq8RGdAPNWiAASKjfuU/43sp2ipztTdFNtzZnGvCqpnPUlRGnLtGseaq0OHxFl6N1bLxacUxR9oRT0afqTf60ydGvmECW3fIVFlPhd4c+UdvQb6slSkI8KxXSPYjNIT58AZ3WDUidk9s8IIWUZ9gMEgIxreSNwkn8Evi0nxFATiQLNfU/JeQQVMlHmTUdpAq39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuB5AmuQMIWHOyEQI/6Bx4+efmjuibLIYHDg2+ZEQlk=;
 b=Mia80neTP2lXAMg3c2R01sz2o9lLAUw/vsPGtS27btXC8p00sZ/amvpN9up2MeyNiWFDAw/wcK+GtmJh9YPBDeoIB8rNKMPcDLjlPSRhTXhpktpJYCT31sa4TLKMwqvKOLrL/KXb0ksPgr1dgkB7nKZ/avlUDMyRBNeArs7rHAjNYOgfTHxSpCJbzQmDN3TBRFjH1lJaxazKNYVAERFJQi7q+qRreAnDj0wSb++98pFVcny8HGEoYvNcWoh5LvfWNUYuYmCeF97lcb3vJ4Aj3V0VSWRyAC0u2PYdIPjKxGtxOJvwN/iZHLAVNmHhPh7DlsHg7+cfjW8KpUS6f7Upbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAWPR04MB9839.eurprd04.prod.outlook.com (2603:10a6:102:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 16:08:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 16:08:10 +0000
Date: Fri, 30 Jan 2026 11:08:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 15/19] dmaengine: ti: k3-udma-v2: New driver for K3
 BCDMA_V2
Message-ID: <aXzXYMixFpuornQF@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-16-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-16-s-adivi@ti.com>
X-ClientProxiedBy: BYAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAWPR04MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: 13aa0d81-acaf-45a4-daac-08de6019c34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|366016|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/fWvw7HnX4Omy/w3CgFp+WwBVR25hLtB67p9maA9e6/HnnBOJq29Aq7o1GC?=
 =?us-ascii?Q?WdFJfx5np0FyvDEymezJXW0GukCUjan8iMZZaSeSaYkjfkfDV0aINIJrGpRi?=
 =?us-ascii?Q?Rpnqv6loBeHUojmyyzI1tXM6FOCNqq9hoxCdsMoYv3xTjWnuFcss7022OP10?=
 =?us-ascii?Q?+WUGD6QRMZnqwapYbyCvts4kyh7KBbE4LcTvMZUQpG1um41RaxNJeNB0Kenl?=
 =?us-ascii?Q?3czpA0mdaOrSsue3BFB+LBHOrC3ao6eLcCJDtzcCuRa5bZTh18I65GRazZyI?=
 =?us-ascii?Q?IECZ7aemxRUmiWHRUFjiBP5cYbEUwNHbTPwcdknnD3BzOnjE8AoP1EmHxWkE?=
 =?us-ascii?Q?DG4x2uWvFjowHF6JXgB6qJud2klvCAQU3tzOngyUdfc/02omUwAJHt2/LeoR?=
 =?us-ascii?Q?PHGqDVwmGOfWhN2TNQkcbvf4/LC6o77t8t72awUqD5rT40yqlJsN6o4quA4k?=
 =?us-ascii?Q?z46LBVjMxygH8fZ8FL96X2CzZAXiA6peTtbIoDnmlD+Hj15lew/KK1xuKqRm?=
 =?us-ascii?Q?gMEgcG7QE7+tGxCJO7IofjrmniAYdNyTumdLi8Z6k6PG2GDS044rkVXocKu6?=
 =?us-ascii?Q?Yl4+2jYEenspk9+FhzpcNibOLdkwdvD/H2sh6HjltqLtyUtxm9zxT2jlfrU9?=
 =?us-ascii?Q?Rq+wL51OaNZAzbXvsddWEkSh1KzHtWcN0ZW9BfSrEfURNPQDbve7jUjvuIiH?=
 =?us-ascii?Q?EtuoyO7KkWtNH19zfn7shKAt37lHQNro1x/dYF5NguFBWc7s3WNhuYYz6U5y?=
 =?us-ascii?Q?2s70+nkVNNX7tU6fpIJmNSrg7zouGC93SU1GqwRDiFYuBh5ENhnBKiLJruyC?=
 =?us-ascii?Q?XpJor5+zZai9l6CxAc/WVugey17fQlkjJ7ki2S9zvnvj681OwLI+WAgRThya?=
 =?us-ascii?Q?D3K8l/xvKkqSAaEkf1poU7YwNOZIONde4gHXrFoFXcvClz9wBmP1jtJgFS16?=
 =?us-ascii?Q?jbgjFHb6n83arZ9jEb7xNsdbLReG6ahYU+F/6FN/PNTkh/N3Nccvrfo959Hn?=
 =?us-ascii?Q?P6S4N0w43LH9j8uFyj/qyUNKqq+L5ckBsNRA0b5/P1Gmusu9gmrONhhCNcV+?=
 =?us-ascii?Q?n7EitAcLjRmSwdICexCCrbs01/T2ZPNJPd2lL+J9CndSYG04OzdwryGDLXlW?=
 =?us-ascii?Q?mmveijm6uXMPVlh/0n9yNUDNVudHeWNRYrxe/8DB6HCjrWq5hDccpX10PzVw?=
 =?us-ascii?Q?kf7TOrvF/EwkWJRgvEyzVqyKvD9tSAIio1vJcDnTYrM+2pGjQ4L52gAbKukl?=
 =?us-ascii?Q?Dawa6qbZOdzAGMhT+YVOcCmdyrJR7YRM5QKYD8KCpuy9DPGv3WBYUF//QWAR?=
 =?us-ascii?Q?iJTdFuWRM0uP9iMKKYkuCcWgPd635ZWWR5j4cvBfkFip+l1EV4LjcNivnnmf?=
 =?us-ascii?Q?CFZjHNQo3px+YBaDBfc2JGM/drmikCajnadyG/ro0yN3qtuNAEDyNN/Oy+7o?=
 =?us-ascii?Q?r9ika/QWcKSrsNpDTNaI5VeI1vo2GbGKPrqT8BoTIVvbsN06wmG9mHNlcLlx?=
 =?us-ascii?Q?JNw/71qlmoFLz2ljfRmdxCM4mtmI+yOkbZNujBbJzujQlLTOe70TnhAA4TrR?=
 =?us-ascii?Q?AwaSaM81oAYgVKSf7UbL5nGzXUvNw12i5yrJQjEX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(366016)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DhBBi3lhmWYk16pWIc3tAlrmcV6JdbaHodkV0aHW5Sik2sOwcd1/di1mHwWv?=
 =?us-ascii?Q?tfVUm6Sn7M904twW4dOQIa1KsnDzv2Y/Fsa4aOo+MwyGWgCxkylIVfKcaIBx?=
 =?us-ascii?Q?jcnSIakKGLlaan9T5wyDrbXfj8If2yOwiYVjfdZCUeeYZoruBOZP5SjGxsxc?=
 =?us-ascii?Q?aqG6wOc89ax9foaOvnskaGl/2ODLJEh+1t3DZfU81MIT+QssXy5WLoVBb1N+?=
 =?us-ascii?Q?hkng7b5DeOf8OrcfmaKyMuFVMmyigAnErZm8xgGA46gygitavKWjETc5b9/n?=
 =?us-ascii?Q?yvBZilQXXGwMCygEeY0UWk5gPhFe5W8IFoVkUewbm2b0l+cpX6MXtmXeQcKd?=
 =?us-ascii?Q?1WaLK6UaeRV0PdAqF1VlhohLoFvr0xAm2DXgLQLYyHnuGxEPEDrT6UpuV5WP?=
 =?us-ascii?Q?xcj7gJCvCK7sweYbaFDghvTtIgCrPlCw46VoHEA/owYVRNgDyx7w+DCRyapr?=
 =?us-ascii?Q?LZhPKJcqLUQ2uA9DLZNOSeqUFhxVfuBQHyZCzcRMZ6uHYMRv0i7Ptx87X0DW?=
 =?us-ascii?Q?jmJkTXYmTi2VHNlkMEYoLNJPQRVl2afCM7jFDFzATTHGHM4nEFH6Z8zef7x5?=
 =?us-ascii?Q?sFtWbz+Y8O2DJ/X9+NDnW+XM6zxtzUajJfTFG3dBXmThq2YlqB+74RCCjhoN?=
 =?us-ascii?Q?huHm9jXByKh0+BeuLsDcm9UNzy8AW378Q7p1Hz8/bdRgIY1l2mSLW3rqroCT?=
 =?us-ascii?Q?1tQXxBZoBA558l6r4TLc5P0Qc0h+h35/cSQkleRjgOPakSsPANw2KT6S55WA?=
 =?us-ascii?Q?d9mroibGt7UwQto+SO6IgPli599r9/mMZRIZ7Ql0VIIXRe+yxtapYKdoO3ms?=
 =?us-ascii?Q?GM/oksD6+31pMOAzpn9VZb3s7X40rp7RCgjTy4NJnYYCa3mrXi2RoXFVTv08?=
 =?us-ascii?Q?3tN4M9/ByaHsKhbxTv0Zr7V96c+JmsWA70ahXRW9hM9e1MXBEB3KpCsng37Q?=
 =?us-ascii?Q?W/HYMPc20wrJm/AbgmGN8O5tuCggxFuP0VEzQ7ybXYO63VkV8MIiBtJQke6Z?=
 =?us-ascii?Q?2yquzOI/u7grp+araLDacY5KK8YS3NOvBJZ0hmvz24gMwq193m3GbijqDDa7?=
 =?us-ascii?Q?+dmzystW/THg1DaFQNZaKmcSwZSBklgx2zmHQHdpNhe5tLF1oFG7kAWAjsSZ?=
 =?us-ascii?Q?gFPIB5CKOEK575Rts0+Y7ASDcmlEYNkBBsBzSmNPqxT8EgzI4aemzf+ERHPp?=
 =?us-ascii?Q?23OPYNQ7lyy1NJ/mEFs2GPkL6UIMFz5+uT373SU2Ax+gic+m7I7P9c/vXZwK?=
 =?us-ascii?Q?++vkBACdc1i3NuYH/fPLMvAArdlEr2enr3VcchGomyJz1s4hLFClU/WD/S0N?=
 =?us-ascii?Q?1rGSIiTcvh1oks0c7hCICvx/H06Hx94GsOvsQIhwCDkhSp0BD/GRIq5sZCVC?=
 =?us-ascii?Q?lFwkSh1HdXnex5F/NSSmAHNdgybBbntw7LIRsyL6sSOtTp4zraoSb/ACBqEu?=
 =?us-ascii?Q?dDXbKccNyO/4NkNErLUJGsT22wuDDmFiLu5j+WZILDKb+RPvdaTJ4OxrzW36?=
 =?us-ascii?Q?+FNoMDvYgQmwj6I5G8ykzgxT9F7Qf/fI5BOBRna4g2xbdrDdCxFVAMkLbdYC?=
 =?us-ascii?Q?clVuE+Maj16s229KbReSeVuUUDv6ZuYRuL+OD3kmYh6F4h924CzG+6S35N5x?=
 =?us-ascii?Q?76fNuaIWX1FaoKxNwCEEge3a48EC87R9t4cinyw/Tf+3J19Op/NEkoCsf5Wa?=
 =?us-ascii?Q?RHHKJj+IHkWQuLsMlIGdwFyePWgeajxcgVBmVwiytRn4Qyag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13aa0d81-acaf-45a4-daac-08de6019c34d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 16:08:10.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAjl1OvKKP1LA+rnUaDLRwdZSkSfmVAJtoTN7iwv/yzOleTn0L1a0NdiIXg6qK70M336WemidxWJGnzHFbppPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9839
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8628-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,ti.com:url,ti.com:email,out_irq.np:url]
X-Rspamd-Queue-Id: 1454BBC66A
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:55PM +0530, Sai Sree Kartheek Adivi wrote:
> Add support for BCDMA_V2.
>
> The BCDMA_V2 is different than the existing BCDMA supported by the
> k3-udma driver.
>
> The changes in BCDMA_V2 are:
> - Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
>   needs to set in the RT_CTL register.
> - Static channel mapping: Each channel is mapped to a single peripheral.
> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>   directly connected to GIC.
> - Remote side configuration handled by DMA. So no need to write to PEER
>   registers to START / STOP / PAUSE / TEARDOWN.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/Kconfig            |   16 +-
>  drivers/dma/ti/Makefile           |    1 +
>  drivers/dma/ti/k3-udma-common.c   |   75 +-
>  drivers/dma/ti/k3-udma-v2.c       | 1283 +++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.h          |  117 +--
>  include/linux/soc/ti/k3-ringacc.h |    3 +
>  6 files changed, 1429 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/dma/ti/k3-udma-v2.c
>
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 712e456015459..ada2ea8aca4b0 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -49,6 +49,18 @@ config TI_K3_UDMA
>  	  Enable support for the TI UDMA (Unified DMA) controller. This
>  	  DMA engine is used in AM65x and j721e.
>
> +config TI_K3_UDMA_V2
> +	tristate "Texas Instruments K3 UDMA v2 support"
> +	depends on ARCH_K3
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select TI_K3_UDMA_COMMON
> +	select TI_K3_RINGACC
> +	select TI_K3_PSIL
> +        help
> +	  Enable support for the TI UDMA (Unified DMA) v2 controller. This
> +	  DMA engine is used in AM62L.
> +
>  config TI_K3_UDMA_COMMON
>  	tristate
>  	default n
> @@ -56,14 +68,14 @@ config TI_K3_UDMA_COMMON
>  config TI_K3_UDMA_GLUE_LAYER
>  	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>  	depends on ARCH_K3 || COMPILE_TEST
> -	depends on TI_K3_UDMA
> +	depends on TI_K3_UDMA || TI_K3_UDMA_V2
>  	help
>  	  Say y here to support the K3 NAVSS DMA glue interface
>  	  If unsure, say N.
>
>  config TI_K3_PSIL
>         tristate
> -       default TI_K3_UDMA
> +       default TI_K3_UDMA || TI_K3_UDMA_V2
>
>  config TI_DMA_CROSSBAR
>  	bool
> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
> index 41bfba944dc6c..296aa3421e71b 100644
> --- a/drivers/dma/ti/Makefile
> +++ b/drivers/dma/ti/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
>  obj-$(CONFIG_TI_EDMA) += edma.o
>  obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>  obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
> +obj-$(CONFIG_TI_K3_UDMA_V2) += k3-udma-v2.o
>  obj-$(CONFIG_TI_K3_UDMA_COMMON) += k3-udma-common.o
>  obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
>  k3-psil-lib-objs := k3-psil.o \
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index 0ffc6becc402e..ba0fc048234ac 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -171,8 +171,13 @@ bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>  		return true;
>
> -	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> -	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	if (uc->ud->match_data->type >= DMA_TYPE_BCDMA_V2) {
> +		peer_bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG);
> +		bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	} else {
> +		peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> +		bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	}
>
>  	/* Transfer is incomplete, store current residue and time stamp */
>  	if (peer_bcnt < bcnt) {
> @@ -319,6 +324,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	size_t tr_size;
>  	int num_tr = 0;
>  	int tr_idx = 0;
> +	u32 extra_flags = 0;
>  	u64 asel;
>
>  	/* estimate the number of TRs we will need */
> @@ -342,6 +348,9 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	else
>  		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
>
> +	if (dir == DMA_MEM_TO_DEV && uc->ud->match_data->type == DMA_TYPE_BCDMA_V2)
> +		extra_flags = CPPI5_TR_CSF_EOP;
> +
>  	tr_req = d->hwdesc[0].tr_req_base;
>  	for_each_sg(sgl, sgent, sglen, i) {
>  		dma_addr_t sg_addr = sg_dma_address(sgent);
> @@ -358,7 +367,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>
>  		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
>  			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>
>  		sg_addr |= asel;
>  		tr_req[tr_idx].addr = sg_addr;
> @@ -372,7 +381,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  				      false, false,
>  				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
>  			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +					 CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>
>  			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
>  			tr_req[tr_idx].icnt0 = tr1_cnt0;
> @@ -632,7 +641,8 @@ int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
>  			d->static_tr.bstcnt = d->residue / d->sglen / div;
>  		else
>  			d->static_tr.bstcnt = d->residue / div;
> -	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> +	} else if ((uc->ud->match_data->type == DMA_TYPE_BCDMA ||
> +		   uc->ud->match_data->type == DMA_TYPE_BCDMA_V2) &&
>  		   uc->config.dir == DMA_DEV_TO_MEM &&
>  		   uc->cyclic) {
>  		/*
> @@ -952,7 +962,8 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  	 * last one, so set the flag for each period.
>  	 */
>  	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
> -	    uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> +	    (uc->ud->match_data->type == DMA_TYPE_BCDMA ||
> +		uc->ud->match_data->type == DMA_TYPE_BCDMA_V2)) {
>  		period_csf = CPPI5_TR_CSF_EOP;
>  	}
>
> @@ -1807,7 +1818,8 @@ void udma_dbg_summary_show_chan(struct seq_file *s,
>
>  	switch (uc->config.dir) {
>  	case DMA_MEM_TO_MEM:
> -		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> +		if (uc->ud->match_data->type == DMA_TYPE_BCDMA ||
> +		    uc->ud->match_data->type == DMA_TYPE_BCDMA_V2) {

Can you improve your match_data? use one flags for each feature.?

for example:

	SUPPORT_FEATURE_1, SUPPORT_FEATURE_2


	here just one if

	if (match_data->feature | SUPPORT_FEATURE_1)
		....

at driver data

	for BCDMA

	feature = SUPPORT_FEATURE_1;

	for BCDMA_V2
	feature = SUPPORT_FEATURE_1 : SUPPORT_FEATURE_2;

you can also use bool bit field

Frank Li

>  			seq_printf(s, "bchan%d)\n", uc->bchan->id);
>  			return;
>  		}
> @@ -2052,6 +2064,8 @@ int udma_get_tchan(struct udma_chan *uc)
>  		uc->tchan = NULL;
>  		return ret;
>  	}
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2)
> +		uc->chan = uc->tchan;
>
>  	if (ud->tflow_cnt) {
>  		int tflow_id;
> @@ -2102,6 +2116,8 @@ int udma_get_rchan(struct udma_chan *uc)
>  		uc->rchan = NULL;
>  		return ret;
>  	}
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2)
> +		uc->chan = uc->rchan;
>
>  	return 0;
>  }
> @@ -2379,16 +2395,26 @@ int bcdma_setup_resources(struct udma_dev *ud)
>
>  	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
>  					   sizeof(unsigned long), GFP_KERNEL);
> +	bitmap_zero(ud->bchan_map, ud->bchan_cnt);
>  	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
>  				  GFP_KERNEL);
>  	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
>  					   sizeof(unsigned long), GFP_KERNEL);
> +	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
>  	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
>  				  GFP_KERNEL);
> -	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> -					   sizeof(unsigned long), GFP_KERNEL);
> -	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> -				  GFP_KERNEL);
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
> +		ud->rchan_map = ud->tchan_map;
> +		ud->rchans = ud->tchans;
> +		ud->chan_map = ud->tchan_map;
> +		ud->chans = ud->tchans;
> +	} else {
> +		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> +						   sizeof(unsigned long), GFP_KERNEL);
> +		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> +					  GFP_KERNEL);
> +	}
>  	/* BCDMA do not really have flows, but the driver expect it */
>  	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
>  					sizeof(unsigned long),
> @@ -2472,6 +2498,7 @@ int setup_resources(struct udma_dev *ud)
>  		ret = ud->udma_setup_resources(ud);
>  		break;
>  	case DMA_TYPE_BCDMA:
> +	case DMA_TYPE_BCDMA_V2:
>  		ret = bcdma_setup_resources(ud);
>  		break;
>  	case DMA_TYPE_PKTDMA:
> @@ -2484,11 +2511,18 @@ int setup_resources(struct udma_dev *ud)
>  	if (ret)
>  		return ret;
>
> -	ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
> -	if (ud->bchan_cnt)
> -		ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> -	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> -	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
> +		ch_count = ud->bchan_cnt + ud->tchan_cnt;
> +		if (ud->bchan_cnt)
> +			ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> +		ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> +	} else {
> +		ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
> +		if (ud->bchan_cnt)
> +			ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> +		ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> +		ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
> +	}
>  	if (!ch_count)
>  		return -ENODEV;
>
> @@ -2520,6 +2554,15 @@ int setup_resources(struct udma_dev *ud)
>  			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
>  						       ud->rchan_cnt));
>  		break;
> +	case DMA_TYPE_BCDMA_V2:
> +		dev_info(dev,
> +			 "Channels: %d (bchan: %u, chan: %u)\n",
> +			 ch_count,
> +			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
> +						       ud->bchan_cnt),
> +			 ud->chan_cnt - bitmap_weight(ud->chan_map,
> +						       ud->chan_cnt));
> +		break;
>  	case DMA_TYPE_PKTDMA:
>  		dev_info(dev,
>  			 "Channels: %d (tchan: %u, rchan: %u)\n",
> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
> new file mode 100644
> index 0000000000000..af06d25fd598b
> --- /dev/null
> +++ b/drivers/dma/ti/k3-udma-v2.c
> @@ -0,0 +1,1283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Derived from K3 UDMA driver (k3-udma.c)
> + *  Copyright (C) 2024-2025 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *  Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_irq.h>
> +#include <linux/workqueue.h>
> +#include <linux/completion.h>
> +#include <linux/iopoll.h>
> +#include <linux/soc/ti/k3-ringacc.h>
> +
> +#include "../virt-dma.h"
> +#include "k3-udma.h"
> +#include "k3-psil-priv.h"
> +
> +static const char * const v2_mmr_names[] = {
> +	[V2_MMR_GCFG] = "gcfg",
> +	[V2_MMR_BCHANRT] = "bchanrt",
> +	[V2_MMR_CHANRT] = "chanrt",
> +};
> +
> +static int udma_v2_check_chan_autopair_completion(struct udma_chan *uc)
> +{
> +	u32 val;
> +
> +	val = udma_chanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> +	if (val & UDMA_CHAN_RT_CTL_PAIR_TIMEOUT)
> +		return -ETIMEDOUT;
> +	else if (val & UDMA_CHAN_RT_CTL_PAIR_COMPLETE)
> +		return 1;
> +
> +	/* timeout didn't occur and also pairing didn't happen yet. */
> +	return 0;
> +}
> +
> +static bool udma_v2_is_chan_paused(struct udma_chan *uc)
> +{
> +	u32 val, pause_mask;
> +
> +	if (uc->config.dir == DMA_MEM_TO_MEM) {
> +		val = udma_chanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> +		pause_mask = UDMA_CHAN_RT_CTL_PAUSE;
> +	} else {
> +		val = udma_chanrt_read(uc, UDMA_CHAN_RT_PDMA_STATE_REG);
> +		pause_mask = UDMA_CHAN_RT_PDMA_STATE_PAUSE;
> +	}
> +
> +	if (val & pause_mask)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void udma_v2_decrement_byte_counters(struct udma_chan *uc, u32 val)
> +{
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +	if (uc->config.ep_type != PSIL_EP_NATIVE)
> +		udma_chanrt_write(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG, val);
> +}
> +
> +static void udma_v2_reset_counters(struct udma_chan *uc)
> +{
> +	u32 val;
> +
> +	val = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +
> +	val = udma_chanrt_read(uc, UDMA_CHAN_RT_SBCNT_REG);
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +
> +	val = udma_chanrt_read(uc, UDMA_CHAN_RT_PCNT_REG);
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_PCNT_REG, val);
> +
> +	if (!uc->bchan) {
> +		val = udma_chanrt_read(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG);
> +		udma_chanrt_write(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG, val);
> +	}
> +}
> +
> +static int udma_v2_reset_chan(struct udma_chan *uc, bool hard)
> +{
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_CTL_REG, 0);
> +
> +	/* Reset all counters */
> +	udma_v2_reset_counters(uc);
> +
> +	/* Hard reset: re-initialize the channel to reset */
> +	if (hard) {
> +		struct udma_chan_config ucc_backup;
> +		int ret;
> +
> +		memcpy(&ucc_backup, &uc->config, sizeof(uc->config));
> +		uc->ud->ddev.device_free_chan_resources(&uc->vc.chan);
> +
> +		/* restore the channel configuration */
> +		memcpy(&uc->config, &ucc_backup, sizeof(uc->config));
> +		ret = uc->ud->ddev.device_alloc_chan_resources(&uc->vc.chan);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Setting forced teardown after forced reset helps recovering
> +		 * the rchan.
> +		 */
> +		if (uc->config.dir == DMA_DEV_TO_MEM)
> +			udma_chanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
> +						UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN |
> +						UDMA_CHAN_RT_CTL_FTDOWN,
> +						UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN |
> +						UDMA_CHAN_RT_CTL_FTDOWN);
> +	}
> +	uc->state = UDMA_CHAN_IS_IDLE;
> +
> +	return 0;
> +}
> +
> +static int udma_v2_start(struct udma_chan *uc)
> +{
> +	struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
> +	struct udma_dev *ud = uc->ud;
> +	int status, ret;
> +
> +	if (!vd) {
> +		uc->desc = NULL;
> +		return -ENOENT;
> +	}
> +
> +	list_del(&vd->node);
> +
> +	uc->desc = to_udma_desc(&vd->tx);
> +
> +	/* Channel is already running and does not need reconfiguration */
> +	if (udma_is_chan_running(uc) && !udma_chan_needs_reconfiguration(uc)) {
> +		udma_start_desc(uc);
> +		goto out;
> +	}
> +
> +	/* Make sure that we clear the teardown bit, if it is set */
> +	ud->reset_chan(uc, false);
> +
> +	/* Push descriptors before we start the channel */
> +	udma_start_desc(uc);
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		/* Config remote TR */
> +		if (uc->config.ep_type == PSIL_EP_PDMA_XY) {
> +			u32 val = PDMA_STATIC_TR_Y(uc->desc->static_tr.elcnt) |
> +				  PDMA_STATIC_TR_X(uc->desc->static_tr.elsize);
> +			const struct udma_match_data *match_data =
> +							uc->ud->match_data;
> +
> +			if (uc->config.enable_acc32)
> +				val |= PDMA_STATIC_TR_XY_ACC32;
> +			if (uc->config.enable_burst)
> +				val |= PDMA_STATIC_TR_XY_BURST;
> +
> +			udma_chanrt_write(uc,
> +					  UDMA_CHAN_RT_STATIC_TR_XY_REG,
> +					  val);
> +
> +			udma_chanrt_write(uc,
> +					  UDMA_CHAN_RT_STATIC_TR_Z_REG,
> +					  PDMA_STATIC_TR_Z(uc->desc->static_tr.bstcnt,
> +							   match_data->statictr_z_mask));
> +
> +			/* save the current staticTR configuration */
> +			memcpy(&uc->static_tr, &uc->desc->static_tr,
> +			       sizeof(uc->static_tr));
> +		}
> +
> +		udma_chanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
> +				  UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_AUTOPAIR);
> +
> +		/* Poll for autopair completion */
> +		ret = read_poll_timeout_atomic(udma_v2_check_chan_autopair_completion,
> +					       status, status != 0, 100, 500, false, uc);
> +
> +		if (status <= 0)
> +			return ret;
> +
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		/* Config remote TR */
> +		if (uc->config.ep_type == PSIL_EP_PDMA_XY) {
> +			u32 val = PDMA_STATIC_TR_Y(uc->desc->static_tr.elcnt) |
> +				  PDMA_STATIC_TR_X(uc->desc->static_tr.elsize);
> +
> +			if (uc->config.enable_acc32)
> +				val |= PDMA_STATIC_TR_XY_ACC32;
> +			if (uc->config.enable_burst)
> +				val |= PDMA_STATIC_TR_XY_BURST;
> +
> +			udma_chanrt_write(uc,
> +					  UDMA_CHAN_RT_STATIC_TR_XY_REG,
> +					  val);
> +
> +			/* save the current staticTR configuration */
> +			memcpy(&uc->static_tr, &uc->desc->static_tr,
> +			       sizeof(uc->static_tr));
> +		}
> +
> +		udma_chanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
> +				  UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_AUTOPAIR);
> +
> +		/* Poll for autopair completion */
> +		ret = read_poll_timeout_atomic(udma_v2_check_chan_autopair_completion,
> +					       status, status != 0, 100, 500, false, uc);
> +
> +		if (status <= 0)
> +			return -ETIMEDOUT;
> +
> +		break;
> +	case DMA_MEM_TO_MEM:
> +		udma_bchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
> +				   UDMA_CHAN_RT_CTL_EN);
> +		udma_bchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
> +				   UDMA_CHAN_RT_CTL_EN);
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	uc->state = UDMA_CHAN_IS_ACTIVE;
> +out:
> +
> +	return 0;
> +}
> +
> +static int udma_v2_stop(struct udma_chan *uc)
> +{
> +	uc->state = UDMA_CHAN_IS_TERMINATING;
> +	reinit_completion(&uc->teardown_completed);
> +
> +	if (uc->config.dir == DMA_DEV_TO_MEM) {
> +		if (!uc->cyclic && !uc->desc)
> +			udma_push_to_ring(uc, -1);
> +	}
> +
> +	udma_chanrt_write(uc, UDMA_CHAN_RT_PEER_REG(8), UDMA_CHAN_RT_PEER_REG8_FLUSH);
> +	udma_chanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
> +				UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN,
> +				UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t udma_v2_udma_irq_handler(int irq, void *data)
> +{
> +	struct udma_chan *uc = data;
> +	struct udma_dev *ud = uc->ud;
> +	struct udma_desc *d;
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		k3_ringacc_ring_clear_irq(uc->rflow->r_ring);
> +		break;
> +	case DMA_MEM_TO_DEV:
> +	case DMA_MEM_TO_MEM:
> +		k3_ringacc_ring_clear_irq(uc->tchan->tc_ring);
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	spin_lock(&uc->vc.lock);
> +	d = uc->desc;
> +	if (d) {
> +		d->tr_idx = (d->tr_idx + 1) % d->sglen;
> +
> +		if (uc->cyclic) {
> +			vchan_cyclic_callback(&d->vd);
> +		} else {
> +			/* TODO: figure out the real amount of data */
> +			ud->decrement_byte_counters(uc, d->residue);
> +			ud->start(uc);
> +			vchan_cookie_complete(&d->vd);
> +		}
> +	}
> +
> +	spin_unlock(&uc->vc.lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t udma_v2_ring_irq_handler(int irq, void *data)
> +{
> +	struct udma_chan *uc = data;
> +	struct udma_dev *ud = uc->ud;
> +	struct udma_desc *d;
> +	dma_addr_t paddr = 0;
> +	u32 intr_status, reg;
> +
> +	switch (uc->config.dir) {
> +	case DMA_DEV_TO_MEM:
> +		intr_status =  k3_ringacc_ring_get_irq_status(uc->rflow->r_ring);
> +		break;
> +	case DMA_MEM_TO_DEV:
> +	case DMA_MEM_TO_MEM:
> +		intr_status =  k3_ringacc_ring_get_irq_status(uc->tchan->tc_ring);
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	reg = udma_chanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
> +
> +	if (intr_status & K3_RINGACC_RT_INT_STATUS_TR) {
> +		/* check teardown status */
> +		if ((reg & UDMA_CHAN_RT_CTL_TDOWN) && !(reg & UDMA_CHAN_RT_CTL_EN))
> +			complete_all(&uc->teardown_completed);
> +		return udma_v2_udma_irq_handler(irq, data);
> +	}
> +
> +	if (udma_pop_from_ring(uc, &paddr) || !paddr)
> +		return IRQ_HANDLED;
> +
> +	spin_lock(&uc->vc.lock);
> +
> +	/* Teardown completion message */
> +	if (cppi5_desc_is_tdcm(paddr)) {
> +		complete_all(&uc->teardown_completed);
> +
> +		if (uc->terminated_desc) {
> +			udma_desc_free(&uc->terminated_desc->vd);
> +			uc->terminated_desc = NULL;
> +		}
> +
> +		if (!uc->desc)
> +			ud->start(uc);
> +
> +		goto out;
> +	}
> +
> +	d = udma_udma_desc_from_paddr(uc, paddr);
> +
> +	if (d) {
> +		dma_addr_t desc_paddr = udma_curr_cppi5_desc_paddr(d,
> +								   d->desc_idx);
> +		if (desc_paddr != paddr) {
> +			dev_err(uc->ud->dev, "not matching descriptors!\n");
> +			goto out;
> +		}
> +
> +		if (d == uc->desc) {
> +			/* active descriptor */
> +			if (uc->cyclic) {
> +				udma_cyclic_packet_elapsed(uc);
> +				vchan_cyclic_callback(&d->vd);
> +			} else {
> +				if (udma_is_desc_really_done(uc, d)) {
> +					ud->decrement_byte_counters(uc, d->residue);
> +					ud->start(uc);
> +					vchan_cookie_complete(&d->vd);
> +				} else {
> +					schedule_delayed_work(&uc->tx_drain.work,
> +							      0);
> +				}
> +			}
> +		} else {
> +			/*
> +			 * terminated descriptor, mark the descriptor as
> +			 * completed to update the channel's cookie marker
> +			 */
> +			dma_cookie_complete(&d->vd.tx);
> +		}
> +	}
> +out:
> +	spin_unlock(&uc->vc.lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bcdma_v2_get_bchan(struct udma_chan *uc)
> +{
> +	struct udma_dev *ud = uc->ud;
> +	enum udma_tp_level tpl;
> +	int ret;
> +
> +	if (uc->bchan) {
> +		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
> +			uc->id, uc->bchan->id);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Use normal channels for peripherals, and highest TPL channel for
> +	 * mem2mem
> +	 */
> +	if (uc->config.tr_trigger_type)
> +		tpl = 0;
> +	else
> +		tpl = ud->bchan_tpl.levels - 1;
> +
> +	uc->bchan = __udma_reserve_bchan(ud, tpl, uc->id);
> +	if (IS_ERR(uc->bchan)) {
> +		ret = PTR_ERR(uc->bchan);
> +		uc->bchan = NULL;
> +		return ret;
> +	}
> +	uc->chan = uc->bchan;
> +	uc->tchan = uc->bchan;
> +
> +	return 0;
> +}
> +
> +static int bcdma_v2_alloc_bchan_resources(struct udma_chan *uc)
> +{
> +	struct k3_ring_cfg ring_cfg;
> +	struct udma_dev *ud = uc->ud;
> +	int ret;
> +
> +	ret = bcdma_v2_get_bchan(uc);
> +	if (ret)
> +		return ret;
> +
> +	ret = k3_ringacc_request_rings_pair(ud->ringacc, ud->match_data->chan_cnt + uc->id, -1,
> +					    &uc->bchan->t_ring,
> +					    &uc->bchan->tc_ring);
> +	if (ret) {
> +		ret = -EBUSY;
> +		goto err_ring;
> +	}
> +
> +	memset(&ring_cfg, 0, sizeof(ring_cfg));
> +	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
> +	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
> +	ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
> +
> +	k3_configure_chan_coherency(&uc->vc.chan, ud->asel);
> +	ring_cfg.asel = ud->asel;
> +	ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
> +
> +	ret = k3_ringacc_ring_cfg(uc->bchan->t_ring, &ring_cfg);
> +	if (ret)
> +		goto err_ringcfg;
> +
> +	return 0;
> +
> +err_ringcfg:
> +	k3_ringacc_ring_free(uc->bchan->tc_ring);
> +	uc->bchan->tc_ring = NULL;
> +	k3_ringacc_ring_free(uc->bchan->t_ring);
> +	uc->bchan->t_ring = NULL;
> +	k3_configure_chan_coherency(&uc->vc.chan, 0);
> +err_ring:
> +	bcdma_put_bchan(uc);
> +
> +	return ret;
> +}
> +
> +static int udma_v2_alloc_tx_resources(struct udma_chan *uc)
> +{
> +	struct k3_ring_cfg ring_cfg;
> +	struct udma_dev *ud = uc->ud;
> +	struct udma_tchan *tchan;
> +	int ring_idx, ret;
> +
> +	ret = udma_get_tchan(uc);
> +	if (ret)
> +		return ret;
> +
> +	tchan = uc->tchan;
> +	if (tchan->tflow_id >= 0)
> +		ring_idx = tchan->tflow_id;
> +	else
> +		ring_idx = tchan->id;
> +
> +	ret = k3_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
> +					    &tchan->t_ring,
> +					    &tchan->tc_ring);
> +	if (ret) {
> +		ret = -EBUSY;
> +		goto err_ring;
> +	}
> +
> +	memset(&ring_cfg, 0, sizeof(ring_cfg));
> +	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
> +	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
> +	ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
> +
> +	k3_configure_chan_coherency(&uc->vc.chan, uc->config.asel);
> +	ring_cfg.asel = uc->config.asel;
> +	ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
> +
> +	ret = k3_ringacc_ring_cfg(tchan->t_ring, &ring_cfg);
> +	ret |= k3_ringacc_ring_cfg(tchan->tc_ring, &ring_cfg);
> +
> +	if (ret)
> +		goto err_ringcfg;
> +
> +	return 0;
> +
> +err_ringcfg:
> +	k3_ringacc_ring_free(uc->tchan->tc_ring);
> +	uc->tchan->tc_ring = NULL;
> +	k3_ringacc_ring_free(uc->tchan->t_ring);
> +	uc->tchan->t_ring = NULL;
> +err_ring:
> +	udma_put_tchan(uc);
> +
> +	return ret;
> +}
> +
> +static int udma_v2_alloc_rx_resources(struct udma_chan *uc)
> +{
> +	struct udma_dev *ud = uc->ud;
> +	struct k3_ring_cfg ring_cfg;
> +	struct udma_rflow *rflow;
> +	int fd_ring_id;
> +	int ret;
> +
> +	ret = udma_get_rchan(uc);
> +	if (ret)
> +		return ret;
> +
> +	/* For MEM_TO_MEM we don't need rflow or rings */
> +	if (uc->config.dir == DMA_MEM_TO_MEM)
> +		return 0;
> +
> +	if (uc->config.default_flow_id >= 0)
> +		ret = udma_get_rflow(uc, uc->config.default_flow_id);
> +	else
> +		ret = udma_get_rflow(uc, uc->rchan->id);
> +
> +	if (ret) {
> +		ret = -EBUSY;
> +		goto err_rflow;
> +	}
> +
> +	rflow = uc->rflow;
> +	if (ud->tflow_cnt)
> +		fd_ring_id = ud->tflow_cnt + rflow->id;
> +	else
> +		fd_ring_id = uc->rchan->id;
> +	ret = k3_ringacc_request_rings_pair(ud->ringacc, fd_ring_id, -1,
> +					    &rflow->fd_ring, &rflow->r_ring);
> +	if (ret) {
> +		ret = -EBUSY;
> +		goto err_ring;
> +	}
> +
> +	memset(&ring_cfg, 0, sizeof(ring_cfg));
> +
> +	ring_cfg.elm_size = K3_RINGACC_RING_ELSIZE_8;
> +	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
> +	ring_cfg.mode = K3_RINGACC_RING_MODE_RING;
> +
> +	k3_configure_chan_coherency(&uc->vc.chan, uc->config.asel);
> +	ring_cfg.asel = uc->config.asel;
> +	ring_cfg.dma_dev = dmaengine_get_dma_device(&uc->vc.chan);
> +
> +	ret = k3_ringacc_ring_cfg(rflow->fd_ring, &ring_cfg);
> +
> +	ring_cfg.size = K3_UDMA_DEFAULT_RING_SIZE;
> +	ret |= k3_ringacc_ring_cfg(rflow->r_ring, &ring_cfg);
> +
> +	if (ret)
> +		goto err_ringcfg;
> +
> +	return 0;
> +
> +err_ringcfg:
> +	k3_ringacc_ring_free(rflow->r_ring);
> +	rflow->r_ring = NULL;
> +	k3_ringacc_ring_free(rflow->fd_ring);
> +	rflow->fd_ring = NULL;
> +err_ring:
> +	udma_put_rflow(uc);
> +err_rflow:
> +	udma_put_rchan(uc);
> +
> +	return ret;
> +}
> +
> +static int bcdma_v2_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	struct udma_dev *ud = to_udma_dev(chan->device);
> +	u32 irq_ring_idx;
> +	__be32 addr[2] = {0, 0};
> +	struct of_phandle_args out_irq;
> +	int ret;
> +
> +	/* Only TR mode is supported */
> +	uc->config.pkt_mode = false;
> +
> +	/*
> +	 * Make sure that the completion is in a known state:
> +	 * No teardown, the channel is idle
> +	 */
> +	reinit_completion(&uc->teardown_completed);
> +	complete_all(&uc->teardown_completed);
> +	uc->state = UDMA_CHAN_IS_IDLE;
> +
> +	switch (uc->config.dir) {
> +	case DMA_MEM_TO_MEM:
> +		/* Non synchronized - mem to mem type of transfer */
> +		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-MEM\n", __func__,
> +			uc->id);
> +
> +		ret = bcdma_v2_alloc_bchan_resources(uc);
> +		if (ret)
> +			return ret;
> +
> +		irq_ring_idx = ud->match_data->chan_cnt + uc->id;
> +		break;
> +	case DMA_MEM_TO_DEV:
> +		/* Slave transfer synchronized - mem to dev (TX) transfer */
> +		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
> +			uc->id);
> +
> +		ret = udma_v2_alloc_tx_resources(uc);
> +		if (ret) {
> +			uc->config.remote_thread_id = -1;
> +			return ret;
> +		}
> +
> +		uc->config.src_thread = ud->psil_base + uc->tchan->id;
> +		uc->config.dst_thread = uc->config.remote_thread_id;
> +		uc->config.dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
> +
> +		irq_ring_idx = uc->tchan->id;
> +
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		/* Slave transfer synchronized - dev to mem (RX) transfer */
> +		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
> +			uc->id);
> +
> +		ret = udma_v2_alloc_rx_resources(uc);
> +		if (ret) {
> +			uc->config.remote_thread_id = -1;
> +			return ret;
> +		}
> +
> +		uc->config.src_thread = uc->config.remote_thread_id;
> +		uc->config.dst_thread = (ud->psil_base + uc->rchan->id) |
> +					K3_PSIL_DST_THREAD_ID_OFFSET;
> +
> +		irq_ring_idx = uc->rchan->id;
> +
> +		break;
> +	default:
> +		/* Can not happen */
> +		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
> +			__func__, uc->id, uc->config.dir);
> +		return -EINVAL;
> +	}
> +
> +	/* check if the channel configuration was successful */
> +	if (ret)
> +		goto err_res_free;
> +
> +	if (udma_is_chan_running(uc)) {
> +		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
> +		ud->reset_chan(uc, false);
> +		if (udma_is_chan_running(uc)) {
> +			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
> +			ret = -EBUSY;
> +			goto err_res_free;
> +		}
> +	}
> +
> +	uc->dma_dev = dmaengine_get_dma_device(chan);
> +	if (uc->config.dir == DMA_MEM_TO_MEM  && !uc->config.tr_trigger_type) {
> +		uc->config.hdesc_size =
> +			cppi5_trdesc_calc_size(sizeof(struct cppi5_tr_type15_t), 2);
> +
> +		uc->hdesc_pool = dma_pool_create(uc->name, ud->ddev.dev,
> +						 uc->config.hdesc_size,
> +						 ud->desc_align,
> +						 0);
> +		if (!uc->hdesc_pool) {
> +			dev_err(ud->ddev.dev,
> +				"Descriptor pool allocation failed\n");
> +			uc->use_dma_pool = false;
> +			ret = -ENOMEM;
> +			goto err_res_free;
> +		}
> +
> +		uc->use_dma_pool = true;
> +	} else if (uc->config.dir != DMA_MEM_TO_MEM) {
> +		uc->psil_paired = true;
> +	}
> +
> +	out_irq.np = dev_of_node(ud->dev);
> +	out_irq.args_count = 1;
> +	out_irq.args[0] = irq_ring_idx;
> +	ret = of_irq_parse_raw(addr, &out_irq);
> +	if (ret)
> +		return ret;
> +
> +	uc->irq_num_ring = irq_create_of_mapping(&out_irq);
> +
> +	ret = devm_request_irq(ud->dev, uc->irq_num_ring, udma_v2_ring_irq_handler,
> +			       IRQF_TRIGGER_HIGH, uc->name, uc);
> +	if (ret) {
> +		dev_err(ud->dev, "chan%d: ring irq request failed\n", uc->id);
> +		goto err_irq_free;
> +	}
> +
> +	udma_reset_rings(uc);
> +
> +	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
> +				  udma_check_tx_completion);
> +	return 0;
> +
> +err_irq_free:
> +	uc->irq_num_ring = 0;
> +	uc->irq_num_udma = 0;
> +err_res_free:
> +	bcdma_free_bchan_resources(uc);
> +	udma_free_tx_resources(uc);
> +	udma_free_rx_resources(uc);
> +
> +	udma_reset_uchan(uc);
> +
> +	if (uc->use_dma_pool) {
> +		dma_pool_destroy(uc->hdesc_pool);
> +		uc->use_dma_pool = false;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum dma_status udma_v2_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uc->vc.lock, flags);
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	if (!udma_is_chan_running(uc))
> +		ret = DMA_COMPLETE;
> +
> +	if (ret == DMA_IN_PROGRESS && udma_v2_is_chan_paused(uc))
> +		ret = DMA_PAUSED;
> +
> +	if (ret == DMA_COMPLETE || !txstate)
> +		goto out;
> +
> +	if (uc->desc && uc->desc->vd.tx.cookie == cookie) {
> +		u32 peer_bcnt = 0;
> +		u32 bcnt = 0;
> +		u32 residue = uc->desc->residue;
> +		u32 delay = 0;
> +
> +		if (uc->desc->dir == DMA_MEM_TO_DEV) {
> +			bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_SBCNT_REG);
> +
> +			if (uc->config.ep_type != PSIL_EP_NATIVE) {
> +				peer_bcnt = udma_chanrt_read(uc, 0x810);
> +
> +				if (bcnt > peer_bcnt)
> +					delay = bcnt - peer_bcnt;
> +			}
> +		} else if (uc->desc->dir == DMA_DEV_TO_MEM) {
> +			bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +
> +			if (uc->config.ep_type != PSIL_EP_NATIVE) {
> +				peer_bcnt = udma_chanrt_read(uc, 0x810);
> +
> +				if (peer_bcnt > bcnt)
> +					delay = peer_bcnt - bcnt;
> +			}
> +		} else {
> +			bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +		}
> +
> +		if (bcnt && !(bcnt % uc->desc->residue))
> +			residue = 0;
> +		else
> +			residue -= bcnt % uc->desc->residue;
> +
> +		if (!residue && (uc->config.dir == DMA_DEV_TO_MEM || !delay)) {
> +			ret = DMA_COMPLETE;
> +			delay = 0;
> +		}
> +
> +		dma_set_residue(txstate, residue);
> +		dma_set_in_flight_bytes(txstate, delay);
> +
> +	} else {
> +		ret = DMA_COMPLETE;
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +	return ret;
> +}
> +
> +static int udma_v2_pause(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +
> +	/* pause the channel */
> +	udma_chanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
> +				UDMA_CHAN_RT_CTL_PAUSE, UDMA_CHAN_RT_CTL_PAUSE);
> +
> +	return 0;
> +}
> +
> +static int udma_v2_resume(struct dma_chan *chan)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +
> +	/* resume the channel */
> +	udma_chanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
> +				UDMA_CHAN_RT_CTL_PAUSE, 0);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bcdma_v2_driver;
> +
> +static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct udma_chan_config *ucc;
> +	struct psil_endpoint_config *ep_config;
> +	struct udma_v2_filter_param *filter_param;
> +	struct udma_chan *uc;
> +	struct udma_dev *ud;
> +
> +	if (chan->device->dev->driver != &bcdma_v2_driver.driver)
> +		return false;
> +
> +	uc = to_udma_chan(chan);
> +	ucc = &uc->config;
> +	ud = uc->ud;
> +	filter_param = param;
> +
> +	if (filter_param->asel > 15) {
> +		dev_err(ud->dev, "Invalid channel asel: %u\n",
> +			filter_param->asel);
> +		return false;
> +	}
> +
> +	ucc->remote_thread_id = filter_param->remote_thread_id;
> +	ucc->asel = filter_param->asel;
> +	ucc->tr_trigger_type = filter_param->tr_trigger_type;
> +
> +	if (ucc->tr_trigger_type) {
> +		ucc->dir = DMA_MEM_TO_MEM;
> +		goto triggered_bchan;
> +	} else if (ucc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET) {
> +		ucc->dir = DMA_MEM_TO_DEV;
> +	} else {
> +		ucc->dir = DMA_DEV_TO_MEM;
> +	}
> +
> +	ep_config = psil_get_ep_config(ucc->remote_thread_id);
> +	if (IS_ERR(ep_config)) {
> +		dev_err(ud->dev, "No configuration for psi-l thread 0x%04x\n",
> +			ucc->remote_thread_id);
> +		ucc->dir = DMA_MEM_TO_MEM;
> +		ucc->remote_thread_id = -1;
> +		ucc->atype = 0;
> +		ucc->asel = 0;
> +		return false;
> +	}
> +
> +	ucc->pkt_mode = ep_config->pkt_mode;
> +	ucc->channel_tpl = ep_config->channel_tpl;
> +	ucc->notdpkt = ep_config->notdpkt;
> +	ucc->ep_type = ep_config->ep_type;
> +
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2 &&
> +	    ep_config->mapped_channel_id >= 0) {
> +		ucc->mapped_channel_id = ep_config->mapped_channel_id;
> +		ucc->default_flow_id = ep_config->default_flow_id;
> +	} else {
> +		ucc->mapped_channel_id = -1;
> +		ucc->default_flow_id = -1;
> +	}
> +
> +	ucc->needs_epib = ep_config->needs_epib;
> +	ucc->psd_size = ep_config->psd_size;
> +	ucc->metadata_size =
> +		(ucc->needs_epib ? CPPI5_INFO0_HDESC_EPIB_SIZE : 0) +
> +		ucc->psd_size;
> +
> +	if (ucc->ep_type != PSIL_EP_NATIVE) {
> +		const struct udma_match_data *match_data = ud->match_data;
> +
> +		if ((match_data->flags & UDMA_FLAG_PDMA_ACC32) && ep_config->pdma_acc32)
> +			ucc->enable_acc32 = true;
> +		else
> +			ucc->enable_acc32 = false;
> +
> +		if ((match_data->flags & UDMA_FLAG_PDMA_BURST) && ep_config->pdma_burst)
> +			ucc->enable_burst = true;
> +		else
> +			ucc->enable_burst = false;
> +	}
> +	if (ucc->pkt_mode)
> +		ucc->hdesc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
> +				 ucc->metadata_size, ud->desc_align);
> +
> +	dev_dbg(ud->dev, "chan%d: Remote thread: 0x%04x (%s)\n", uc->id,
> +		ucc->remote_thread_id, dmaengine_get_direction_text(ucc->dir));
> +
> +	return true;
> +
> +triggered_bchan:
> +	dev_dbg(ud->dev, "chan%d: triggered channel (type: %u)\n", uc->id,
> +		ucc->tr_trigger_type);
> +
> +	return true;
> +}
> +
> +static struct dma_chan *udma_v2_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct udma_dev *ud = ofdma->of_dma_data;
> +	dma_cap_mask_t mask = ud->ddev.cap_mask;
> +	struct udma_v2_filter_param filter_param;
> +	struct dma_chan *chan;
> +
> +	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
> +		if (dma_spec->args_count != 4)
> +			return NULL;
> +
> +		filter_param.tr_trigger_type = dma_spec->args[0];
> +		filter_param.trigger_param = dma_spec->args[1];
> +		filter_param.remote_thread_id = dma_spec->args[2];
> +		filter_param.asel = dma_spec->args[3];
> +	} else {
> +		if (dma_spec->args_count != 1 && dma_spec->args_count != 2)
> +			return NULL;
> +
> +		filter_param.remote_thread_id = dma_spec->args[0];
> +		filter_param.tr_trigger_type = 0;
> +		if (dma_spec->args_count == 2)
> +			filter_param.asel = dma_spec->args[1];
> +		else
> +			filter_param.asel = 0;
> +	}
> +
> +	chan = __dma_request_channel(&mask, udma_v2_dma_filter_fn, &filter_param,
> +				     ofdma->of_node);
> +	if (!chan) {
> +		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return chan;
> +}
> +
> +static struct udma_match_data bcdma_v2_am62l_data = {
> +	.type = DMA_TYPE_BCDMA_V2,
> +	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
> +	.enable_memcpy_support = true, /* Supported via bchan */
> +	.flags = UDMA_FLAGS_J7_CLASS,
> +	.statictr_z_mask = GENMASK(23, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */
> +	},
> +	.bchan_cnt = 16,
> +	.chan_cnt = 128,
> +	.tchan_cnt = 128,
> +	.rchan_cnt = 128,
> +};
> +
> +static const struct of_device_id udma_of_match[] = {
> +	{
> +		.compatible = "ti,am62l-dmss-bcdma",
> +		.data = &bcdma_v2_am62l_data,
> +	},
> +	{ /* Sentinel */ },
> +};
> +
> +static const struct soc_device_attribute k3_soc_devices[] = {
> +	{ .family = "AM62LX", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, udma_of_match);
> +
> +static int udma_v2_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
> +{
> +	int i;
> +
> +	ud->mmrs[V2_MMR_GCFG] = devm_platform_ioremap_resource_byname(pdev,
> +								      v2_mmr_names[V2_MMR_GCFG]);
> +	if (IS_ERR(ud->mmrs[V2_MMR_GCFG]))
> +		return PTR_ERR(ud->mmrs[V2_MMR_GCFG]);
> +
> +	ud->bchan_cnt = ud->match_data->bchan_cnt;
> +	/* There are no tchan and rchan in BCDMA_V2.
> +	 * Duplicate chan as tchan and rchan to keep the common code
> +	 * in k3-udma-common.c functional for BCDMA_V2.
> +	 */
> +	ud->chan_cnt = ud->match_data->chan_cnt;
> +	ud->tchan_cnt = ud->match_data->chan_cnt;
> +	ud->rchan_cnt = ud->match_data->chan_cnt;
> +	ud->rflow_cnt = ud->chan_cnt;
> +
> +	for (i = 1; i < V2_MMR_LAST; i++) {
> +		if (i == V2_MMR_BCHANRT && ud->bchan_cnt == 0)
> +			continue;
> +		if (i == V2_MMR_CHANRT && ud->chan_cnt == 0)
> +			continue;
> +
> +		ud->mmrs[i] = devm_platform_ioremap_resource_byname(pdev, v2_mmr_names[i]);
> +		if (IS_ERR(ud->mmrs[i]))
> +			return PTR_ERR(ud->mmrs[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int udma_v2_probe(struct platform_device *pdev)
> +{
> +	const struct soc_device_attribute *soc;
> +	struct device *dev = &pdev->dev;
> +	struct udma_dev *ud;
> +	const struct of_device_id *match;
> +	int i, ret;
> +	int ch_count;
> +
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (ret)
> +		dev_err(dev, "failed to set dma mask stuff\n");
> +
> +	ud = devm_kzalloc(dev, sizeof(*ud), GFP_KERNEL);
> +	if (!ud)
> +		return -ENOMEM;
> +
> +	match = of_match_node(udma_of_match, dev->of_node);
> +	if (!match) {
> +		dev_err(dev, "No compatible match found\n");
> +		return -ENODEV;
> +	}
> +	ud->match_data = match->data;
> +
> +	ud->soc_data = ud->match_data->soc_data;
> +	if (!ud->soc_data) {
> +		soc = soc_device_match(k3_soc_devices);
> +		if (!soc) {
> +			dev_err(dev, "No compatible SoC found\n");
> +			return -ENODEV;
> +		}
> +		ud->soc_data = soc->data;
> +	}
> +	// Setup function pointers
> +	ud->start = udma_v2_start;
> +	ud->stop = udma_v2_stop;
> +	ud->reset_chan = udma_v2_reset_chan;
> +	ud->decrement_byte_counters = udma_v2_decrement_byte_counters;
> +	ud->bcdma_setup_sci_resources = NULL;
> +
> +	ret = udma_v2_get_mmrs(pdev, ud);
> +	if (ret)
> +		return ret;
> +
> +	struct k3_ringacc_init_data ring_init_data = {0};
> +
> +	ring_init_data.num_rings = ud->bchan_cnt + ud->chan_cnt;
> +
> +	ud->ringacc = k3_ringacc_dmarings_init(pdev, &ring_init_data);
> +
> +	if (IS_ERR(ud->ringacc))
> +		return PTR_ERR(ud->ringacc);
> +
> +	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
> +
> +	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
> +	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
> +
> +	ud->ddev.device_config = udma_slave_config;
> +	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
> +	ud->ddev.device_issue_pending = udma_issue_pending;
> +	ud->ddev.device_tx_status = udma_v2_tx_status;
> +	ud->ddev.device_pause = udma_v2_pause;
> +	ud->ddev.device_resume = udma_v2_resume;
> +	ud->ddev.device_terminate_all = udma_terminate_all;
> +	ud->ddev.device_synchronize = udma_synchronize;
> +#ifdef CONFIG_DEBUG_FS
> +	ud->ddev.dbg_summary_show = udma_dbg_summary_show;
> +#endif
> +
> +	ud->ddev.device_alloc_chan_resources =
> +		bcdma_v2_alloc_chan_resources;
> +
> +	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
> +
> +	ud->ddev.src_addr_widths = TI_UDMAC_BUSWIDTHS;
> +	ud->ddev.dst_addr_widths = TI_UDMAC_BUSWIDTHS;
> +	ud->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	ud->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	ud->ddev.desc_metadata_modes = DESC_METADATA_CLIENT |
> +				       DESC_METADATA_ENGINE;
> +	if (ud->match_data->enable_memcpy_support &&
> +	    !(ud->match_data->type == DMA_TYPE_BCDMA && ud->bchan_cnt == 0)) {
> +		dma_cap_set(DMA_MEMCPY, ud->ddev.cap_mask);
> +		ud->ddev.device_prep_dma_memcpy = udma_prep_dma_memcpy;
> +		ud->ddev.directions |= BIT(DMA_MEM_TO_MEM);
> +	}
> +
> +	ud->ddev.dev = dev;
> +	ud->dev = dev;
> +	ud->psil_base = ud->match_data->psil_base;
> +
> +	INIT_LIST_HEAD(&ud->ddev.channels);
> +	INIT_LIST_HEAD(&ud->desc_to_purge);
> +
> +	ch_count = setup_resources(ud);
> +	if (ch_count <= 0)
> +		return ch_count;
> +
> +	spin_lock_init(&ud->lock);
> +	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
> +
> +	ud->desc_align = 64;
> +	if (ud->desc_align < dma_get_cache_alignment())
> +		ud->desc_align = dma_get_cache_alignment();
> +
> +	ret = udma_setup_rx_flush(ud);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ud->bchan_cnt; i++) {
> +		struct udma_bchan *bchan = &ud->bchans[i];
> +
> +		bchan->id = i;
> +		bchan->reg_rt = ud->mmrs[V2_MMR_BCHANRT] + i * 0x1000;
> +	}
> +
> +	for (i = 0; i < ud->tchan_cnt; i++) {
> +		struct udma_tchan *tchan = &ud->tchans[i];
> +
> +		tchan->id = i;
> +		tchan->reg_rt = ud->mmrs[V2_MMR_CHANRT] + i * 0x1000;
> +	}
> +
> +	for (i = 0; i < ud->rchan_cnt; i++) {
> +		struct udma_rchan *rchan = &ud->rchans[i];
> +
> +		rchan->id = i;
> +		rchan->reg_rt = ud->mmrs[V2_MMR_CHANRT] + i * 0x1000;
> +	}
> +
> +	for (i = 0; i < ud->rflow_cnt; i++) {
> +		struct udma_rflow *rflow = &ud->rflows[i];
> +
> +		rflow->id = i;
> +		rflow->reg_rt = ud->rflow_rt + i * 0x2000;
> +	}
> +
> +	for (i = 0; i < ch_count; i++) {
> +		struct udma_chan *uc = &ud->channels[i];
> +
> +		uc->ud = ud;
> +		uc->vc.desc_free = udma_desc_free;
> +		uc->id = i;
> +		uc->bchan = NULL;
> +		uc->tchan = NULL;
> +		uc->rchan = NULL;
> +		uc->config.remote_thread_id = -1;
> +		uc->config.mapped_channel_id = -1;
> +		uc->config.default_flow_id = -1;
> +		uc->config.dir = DMA_MEM_TO_MEM;
> +		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
> +					  dev_name(dev), i);
> +
> +		vchan_init(&uc->vc, &ud->ddev);
> +		/* Use custom vchan completion handling */
> +		tasklet_setup(&uc->vc.task, udma_vchan_complete);
> +		init_completion(&uc->teardown_completed);
> +		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
> +	}
> +
> +	/* Configure the copy_align to the maximum burst size the device supports */
> +	ud->ddev.copy_align = udma_get_copy_align(ud);
> +
> +	ret = dma_async_device_register(&ud->ddev);
> +	if (ret) {
> +		dev_err(dev, "failed to register slave DMA engine: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, ud);
> +
> +	ret = of_dma_controller_register(dev->of_node, udma_v2_of_xlate, ud);
> +	if (ret) {
> +		dev_err(dev, "failed to register of_dma controller\n");
> +		dma_async_device_unregister(&ud->ddev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused udma_v2_pm_suspend(struct device *dev)
> +{
> +	struct udma_dev *ud = dev_get_drvdata(dev);
> +	struct dma_device *dma_dev = &ud->ddev;
> +	struct dma_chan *chan;
> +	struct udma_chan *uc;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count) {
> +			uc = to_udma_chan(chan);
> +			/* backup the channel configuration */
> +			memcpy(&uc->backup_config, &uc->config,
> +			       sizeof(struct udma_chan_config));
> +			dev_dbg(dev, "Suspending channel %s\n",
> +				dma_chan_name(chan));
> +			ud->ddev.device_free_chan_resources(chan);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused udma_v2_pm_resume(struct device *dev)
> +{
> +	struct udma_dev *ud = dev_get_drvdata(dev);
> +	struct dma_device *dma_dev = &ud->ddev;
> +	struct dma_chan *chan;
> +	struct udma_chan *uc;
> +	int ret;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		if (chan->client_count) {
> +			uc = to_udma_chan(chan);
> +			/* restore the channel configuration */
> +			memcpy(&uc->config, &uc->backup_config,
> +			       sizeof(struct udma_chan_config));
> +			dev_dbg(dev, "Resuming channel %s\n",
> +				dma_chan_name(chan));
> +			ret = ud->ddev.device_alloc_chan_resources(chan);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops udma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_v2_pm_suspend, udma_v2_pm_resume)
> +};
> +
> +static struct platform_driver bcdma_v2_driver = {
> +	.driver = {
> +		.name	= "ti-udma-v2",
> +		.of_match_table = udma_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &udma_pm_ops,
> +	},
> +	.probe		= udma_v2_probe,
> +};
> +
> +module_platform_driver(bcdma_v2_driver);
> +MODULE_DESCRIPTION("Texas Instruments K3 UDMA v2 support");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 6a95eb1ece064..ca726ea9864ae 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -28,6 +28,11 @@
>  #define UDMA_CHAN_RT_SWTRIG_REG		0x8
>  #define UDMA_CHAN_RT_STDATA_REG		0x80
>
> +#define UDMA_CHAN_RT_STATIC_TR_XY_REG	0x800
> +#define UDMA_CHAN_RT_STATIC_TR_Z_REG	0x804
> +#define UDMA_CHAN_RT_PERIPH_BCNT_REG	0x810
> +#define UDMA_CHAN_RT_PDMA_STATE_REG		0x80c
> +
>  #define UDMA_CHAN_RT_PEER_REG(i)	(0x200 + ((i) * 0x4))
>  #define UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG	\
>  	UDMA_CHAN_RT_PEER_REG(0)	/* PSI-L: 0x400 */
> @@ -67,8 +72,16 @@
>  #define UDMA_CHAN_RT_CTL_TDOWN		BIT(30)
>  #define UDMA_CHAN_RT_CTL_PAUSE		BIT(29)
>  #define UDMA_CHAN_RT_CTL_FTDOWN		BIT(28)
> +#define UDMA_CHAN_RT_CTL_AUTOPAIR      BIT(23)
> +#define UDMA_CHAN_RT_CTL_PAIR_TIMEOUT  BIT(17)
> +#define UDMA_CHAN_RT_CTL_PAIR_COMPLETE BIT(16)
>  #define UDMA_CHAN_RT_CTL_ERROR		BIT(0)
>
> +/* UDMA_CHAN_RT_PDMA_STATE_REG */
> +#define UDMA_CHAN_RT_PDMA_STATE_IN_EVT		BIT(31)
> +#define UDMA_CHAN_RT_PDMA_STATE_TDOWN		BIT(30)
> +#define UDMA_CHAN_RT_PDMA_STATE_PAUSE		BIT(29)
> +
>  /* UDMA_CHAN_RT_PEER_RT_EN_REG */
>  #define UDMA_PEER_RT_EN_ENABLE		BIT(31)
>  #define UDMA_PEER_RT_EN_TEARDOWN	BIT(30)
> @@ -99,6 +112,9 @@
>   */
>  #define PDMA_STATIC_TR_Z(x, mask)	((x) & (mask))
>
> +/* UDMA_CHAN_RT_PEER_REG(8) */
> +#define UDMA_CHAN_RT_PEER_REG8_FLUSH	0x09000000
> +
>  /* Address Space Select */
>  #define K3_ADDRESS_ASEL_SHIFT		48
>
> @@ -202,6 +218,8 @@ enum k3_dma_type {
>  	DMA_TYPE_UDMA = 0,
>  	DMA_TYPE_BCDMA,
>  	DMA_TYPE_PKTDMA,
> +	DMA_TYPE_BCDMA_V2,
> +	DMA_TYPE_PKTDMA_V2,
>  };
>
>  enum udma_mmr {
> @@ -212,6 +230,13 @@ enum udma_mmr {
>  	MMR_LAST,
>  };
>
> +enum udma_v2_mmr {
> +	V2_MMR_GCFG = 0,
> +	V2_MMR_BCHANRT,
> +	V2_MMR_CHANRT,
> +	V2_MMR_LAST,
> +};
> +
>  struct udma_filter_param {
>  	int remote_thread_id;
>  	u32 atype;
> @@ -219,6 +244,13 @@ struct udma_filter_param {
>  	u32 tr_trigger_type;
>  };
>
> +struct udma_v2_filter_param {
> +	u32 tr_trigger_type;
> +	u32 trigger_param;
> +	int remote_thread_id;
> +	u32 asel;
> +};
> +
>  struct udma_tchan {
>  	void __iomem *reg_rt;
>
> @@ -230,17 +262,13 @@ struct udma_tchan {
>  };
>
>  #define udma_bchan udma_tchan
> +#define udma_rchan udma_tchan
>
>  struct udma_rflow {
>  	int id;
>  	struct k3_ring *fd_ring; /* Free Descriptor ring */
>  	struct k3_ring *r_ring; /* Receive ring */
> -};
> -
> -struct udma_rchan {
>  	void __iomem *reg_rt;
> -
> -	int id;
>  };
>
>  struct udma_oes_offsets {
> @@ -268,6 +296,12 @@ struct udma_match_data {
>  	u32 statictr_z_mask;
>  	u8 burst_size[3];
>  	struct udma_soc_data *soc_data;
> +	u32 bchan_cnt;
> +	u32 chan_cnt;
> +	u32 tchan_cnt;
> +	u32 rchan_cnt;
> +	u32 tflow_cnt;
> +	u32 rflow_cnt;
>  };
>
>  struct udma_soc_data {
> @@ -302,6 +336,7 @@ struct udma_dev {
>  	struct dma_device ddev;
>  	struct device *dev;
>  	void __iomem *mmrs[MMR_LAST];
> +	void __iomem *rflow_rt;
>  	const struct udma_match_data *match_data;
>  	const struct udma_soc_data *soc_data;
>
> @@ -322,12 +357,14 @@ struct udma_dev {
>  	struct udma_rx_flush rx_flush;
>
>  	int bchan_cnt;
> +	int chan_cnt;
>  	int tchan_cnt;
>  	int echan_cnt;
>  	int rchan_cnt;
>  	int rflow_cnt;
>  	int tflow_cnt;
>  	unsigned long *bchan_map;
> +	unsigned long *chan_map;
>  	unsigned long *tchan_map;
>  	unsigned long *rchan_map;
>  	unsigned long *rflow_gp_map;
> @@ -336,6 +373,7 @@ struct udma_dev {
>  	unsigned long *tflow_map;
>
>  	struct udma_bchan *bchans;
> +	struct udma_tchan *chans;
>  	struct udma_tchan *tchans;
>  	struct udma_rchan *rchans;
>  	struct udma_rflow *rflows;
> @@ -430,6 +468,7 @@ struct udma_chan {
>  	char *name;
>
>  	struct udma_bchan *bchan;
> +	struct udma_tchan *chan;
>  	struct udma_tchan *tchan;
>  	struct udma_rchan *rchan;
>  	struct udma_rflow *rflow;
> @@ -499,51 +538,33 @@ static inline void udma_update_bits(void __iomem *base, int reg,
>  		writel(tmp, base + reg);
>  }
>
> -/* TCHANRT */
> -static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
> -{
> -	if (!uc->tchan)
> -		return 0;
> -	return udma_read(uc->tchan->reg_rt, reg);
> +#define _UDMA_REG_ACCESS(channel)					\
> +static inline u32 udma_##channel##rt_read(struct udma_chan *uc, int reg) \
> +{ \
> +	if (!uc->channel) \
> +		return 0; \
> +	return udma_read(uc->channel->reg_rt, reg); \
> +} \
> +\
> +static inline void udma_##channel##rt_write(struct udma_chan *uc, int reg, u32 val) \
> +{ \
> +	if (!uc->channel) \
> +		return; \
> +	udma_write(uc->channel->reg_rt, reg, val); \
> +} \
> +\
> +static inline void udma_##channel##rt_update_bits(struct udma_chan *uc, int reg, \
> +						u32 mask, u32 val) \
> +{ \
> +	if (!uc->channel) \
> +		return; \
> +	udma_update_bits(uc->channel->reg_rt, reg, mask, val); \
>  }
>
> -static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
> -{
> -	if (!uc->tchan)
> -		return;
> -	udma_write(uc->tchan->reg_rt, reg, val);
> -}
> -
> -static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
> -					    u32 mask, u32 val)
> -{
> -	if (!uc->tchan)
> -		return;
> -	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
> -}
> -
> -/* RCHANRT */
> -static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
> -{
> -	if (!uc->rchan)
> -		return 0;
> -	return udma_read(uc->rchan->reg_rt, reg);
> -}
> -
> -static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
> -{
> -	if (!uc->rchan)
> -		return;
> -	udma_write(uc->rchan->reg_rt, reg, val);
> -}
> -
> -static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
> -					    u32 mask, u32 val)
> -{
> -	if (!uc->rchan)
> -		return;
> -	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
> -}
> +_UDMA_REG_ACCESS(chan);
> +_UDMA_REG_ACCESS(bchan);
> +_UDMA_REG_ACCESS(tchan);
> +_UDMA_REG_ACCESS(rchan);
>
>  static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
>  						    int idx)
> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
> index 9f2d141c988bd..1ac01b97dd923 100644
> --- a/include/linux/soc/ti/k3-ringacc.h
> +++ b/include/linux/soc/ti/k3-ringacc.h
> @@ -10,6 +10,9 @@
>
>  #include <linux/types.h>
>
> +#define K3_RINGACC_RT_INT_STATUS_COMPLETE	BIT(0)
> +#define K3_RINGACC_RT_INT_STATUS_TR			BIT(2)
> +
>  struct device_node;
>
>  /**
> --
> 2.34.1
>

