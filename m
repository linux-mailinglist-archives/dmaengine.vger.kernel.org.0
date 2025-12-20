Return-Path: <dmaengine+bounces-7849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B39CD31A2
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95E13011429
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8125270545;
	Sat, 20 Dec 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F4dQFaFb"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14D26F2AD;
	Sat, 20 Dec 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244117; cv=fail; b=Z7skI8xTXF61qGz1e/Zh9wUw//cmtBQ2mJy3dR7dFBGo4/X2juzsdQYTQwmw9zk/774gG3J+gGX/R2aw883evgWiDYrM5mg40benGqamseeT+qIQkOFDbPNp+0h26IL8v5x9XdrY/52ClXB8BJPIOIASQH3Ljypd9MkggxFwnmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244117; c=relaxed/simple;
	bh=kXs9ibBzHYhuvPZBxq7CvfnxERURzBqkjrQykQEFT8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KuRC91c1kshn4IM7bT2aHwohYO1kjann9DolSmyUdnO7qX0DHQsn0DAQ7HyELF2LglfJ/7QhfKSy62dZxa17ytHtEhRGPE+V7vPT39MGTgv3lZimvQRKl721VwjARUYcJbvigtd333mCC9WRl8vgVcH3AQGMBPZ3FYfHRRFvyqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F4dQFaFb; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2mZlkk109K7cNA90ILPF9rqGSmgk3vHhfsQnSGeit415AzHqPS4IFd0mWUFVuFOrhW+xIw0L45dWA1rqh/91yLAycV7dtso7DRdTGSGD0ZW/5fVLeXDIAkN+2J+GQgQFeJIJy+v2umNLjvH1oukKBtaOfqWD5cxT9Hp92h8TgHMV+4YubqxkUmF9foE/h/v91gvhzguRqXskk54jy2+LCqEwn+Fxia5Pj0q5Hs76upnOrIF6+OKBU0s+cF8/aBxnCENrH3D3/bDdj7cf1+kp8vR7dtse9aUi39Fv/5t3rgmX/W1tQQOfHOZX6v5Dm6M5QzBKQKMRlG1TheBmieqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcJwV/OhpKbWFdqhYMo9i8NZgnUQf7dENR/KqXtIj28=;
 b=IJcZ1P6zxwPJ7bUGpeDD2jQDNalV3HIzknkbb0+s2og2aMDA7N80tQ9nNlatjBsGbadtLzoIyqU/KN5TujOBtqwRfDFYsonuSxgMKecpPzaO4geh5RWXhosE3L7IMTnssSjCNaxK58IoHVKncJYW7seQ0r87UFAJu4HNmx0hkc7dDI0+17M7SJPXQy9j5y+FCkMT/P4jboi7Q5UwpzL8pQRi6EH+8ex6rATDud6KqvnxoqdAl8ehIoXtGlzJytfkvfXyZQgeeVCErIg4Vfv4tmqQt8GWRwKbRyVSXeoN3pxy5cppTBmTI+OgnliH4pIJFQ4cPz9L53Eg/GTqZf449g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcJwV/OhpKbWFdqhYMo9i8NZgnUQf7dENR/KqXtIj28=;
 b=F4dQFaFbktOtSTaahtrXSL4aze8mseZI3HEbVM0CMHLvcFUpXY8eJXx8zXSy/UNPIBFFWEf2UYy4BViDSTLJ5UNRcG+1Yiwe3Vk4x81ukUwRCrmtyrL/a5mYp4yXhYoX70BDXBrnAi+ANdrC++ON3JcdSsKcpaydEJvLW7sjfvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2999.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 15:21:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Sat, 20 Dec 2025
 15:21:51 +0000
Date: Sun, 21 Dec 2025 00:21:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 22/35] dmaengine: dw-edma: Serialize RMW on shared
 interrupt registers
Message-ID: <hb24k7jg7cngfg4pomrunvl3cfhqkvw6gmof2xlw5ogd3qswi2@b5ue4gm2zury>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-23-den@valinux.co.jp>
 <aUVjqbk1tQjJ1AEh@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVjqbk1tQjJ1AEh@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:2::24) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2999:EE_
X-MS-Office365-Filtering-Correlation-Id: a536c58e-f462-4b0e-39ef-08de3fdb801f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMKdeE5M0uQeiIrNGyNPwFIz5REYL3FtEk65S2m6htlABeYIS1fz9CuwY57D?=
 =?us-ascii?Q?YvuJbTnnfzlLSkLSr2bqiYxZVar9ACWUPlOMH7rkWiTKgq1ZnhoB883ZkX/e?=
 =?us-ascii?Q?BzXOJ2y8+cw3xVNVtcz0g+5XVbIsfsNeyQzLWONbtuZzm+cnGry4CdMut3hn?=
 =?us-ascii?Q?21bYL+eybPBBosABqlNuxYPh0WspCEa26Dq0HYSrrceuOZkH3fXEDFTJ6Ft6?=
 =?us-ascii?Q?UzV6queGGn6vyj4Wqb0DaN5sqgY9zd+30aGMzinjML6WdG/m1sUayCNx3woT?=
 =?us-ascii?Q?WIu7amfA9doF1qbLtws8d0YF7He1jFvvyHgBsTn39iA8qCfDOn9RAQGiqpDU?=
 =?us-ascii?Q?S3pTm5/nO4hSMqvfiBLIpK3kWXELPQAemZOitTU0/BpWchtVNpsdeIL6oAUx?=
 =?us-ascii?Q?TRVmQwmEUvOTSxZSw0NK8k4DKra+GHVWPCr1ZBkL/oiHq25wjlEJ0lTR17B5?=
 =?us-ascii?Q?wxqtsB4pf8aKpwHI7qrt1Ax+D4uLbSegDrsAWvpNjxbfvDPML6nMoxHBXxX2?=
 =?us-ascii?Q?oxFkRpdTAM+bAS4b1wbwxf/+uZPJ5LHA6Vo5w6Ry6xSKDQA+5aQQI5+JojL0?=
 =?us-ascii?Q?ob4Hn82LWRP7fHRJkJZFnb0Se9olrGtvCGiI+vh/Za8QPmhhdLiijIshoeYn?=
 =?us-ascii?Q?xXMQK162ypdb1Hs7zHWiZmwm5jpOeosN5mTNOu3DkuP2GsE52xNj4UxilTLb?=
 =?us-ascii?Q?5CfRylTPMiL82iRxZHsCmrzTmgbhEmrMPCipir7ppnaoGF36Ojmwg6gpmf0X?=
 =?us-ascii?Q?vNJvq8xz/v2mLa2JMzm9oK3ktYpDfort6nPr6YFyXFRMAP9NjLrioTYz+FSd?=
 =?us-ascii?Q?g9XQboDrleRvFHIy4lT1eBXtOR3AYmeNSXF8a+I4lhz4zs4XsXTPiFFXakI7?=
 =?us-ascii?Q?m8lSk/rSS5AIX9CoHHKsAHAsKNmU0MJH4uoPUDc6LvK+mobJ7cz24S1YWrmA?=
 =?us-ascii?Q?uTUcpzuAWvThyf5anHUzr2EYhm5h8DlkjRAuvB/ae2siCkf/LbyvRThVJQlw?=
 =?us-ascii?Q?OyGb/ECubTkFMJqlwAB9FZVReXxuhcjJCv/fSbBRNBrBpgF/g2dWmti9Mcf1?=
 =?us-ascii?Q?92Ix/szGyB+xGlqNckVA2v84Ct08zqNGdh6UgR7AL3jzpIArctMqLuNe7FME?=
 =?us-ascii?Q?uiGvlUhj+CULHjzERFx84dhKLMwaKNNaNF11cS+b5HT/ay0Y7sPcmZOa5P5u?=
 =?us-ascii?Q?i7bq9217Aw7Ny9tP9mPFOty4eg0GsAInDVabbvnX9+Rkol1zyCtRkhCV4iiP?=
 =?us-ascii?Q?LPLLxnNrFb8tToYwl04TsWBvj3c0MfOBowRhJpxf464PipgHWwXCxDbXsaru?=
 =?us-ascii?Q?5UZ8qadrtTGPxCGSDKwvKUidrGduZJMz6f2aw4E+WvLYaHYQEus5r9XOodXS?=
 =?us-ascii?Q?fGr7J86tkF/j4Gjw0F4LFE7x7Klkwl6oIj/uRojlqCRJm320ix5S+R4CKB+b?=
 =?us-ascii?Q?WhEP8EfQ+r8gbiRkCAMrDhcyibncUMfA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FnicFoX1YkiWHgRj9bShfCgEZqRvvtm4tUqT6V8Bc1M2e6UcKCQWJd5c62O?=
 =?us-ascii?Q?3mFMU1A4nbjJvtYOrO9S7evwPKTkoKiCvxD9+B5/AsPbMFISNdd4UQGU6aJR?=
 =?us-ascii?Q?o4xxRGX7iChRA4GzS8GwaeCfug71DZlGyJc1sXjZhm2gYOUtPdAAP4H1hNF2?=
 =?us-ascii?Q?GA0ovAufh+6qzpmGoIUSKsXOgm2QRumWjfvVLnoduIDWESJ/7MP+waQyXiS6?=
 =?us-ascii?Q?KhQz8/Sch1/CSPPPegqDSVB2T2VQNBJJUcc5ZnALtsRr7oJ5sZ3Cf3r5OLgx?=
 =?us-ascii?Q?vYTDkmcJLDV8Ik6LNCUaVN9nKdrXufYu//jBsXQJ7p0rymORot2pvIkOGp2Z?=
 =?us-ascii?Q?fzN1N6qAp+aGTsJg37t3DxsIC9/5MckJKbtd0+WapcVrtjcmkRtqINDnVRgy?=
 =?us-ascii?Q?GLGsFvpKKClNqhk+pHZyhALnnM8Bk1XiDj2bE+CyJMuiR0pb+x3s4vDuTbsp?=
 =?us-ascii?Q?89fbb9c2kSK7kKYf/E7Br1LQnTVXF0o8eacA0iRa+VxuuBKDrscijYtSuE1A?=
 =?us-ascii?Q?n52zL1PMz6dXfpPkAt5io6OUv8jmDxYt9ln7XzHOKcbK1xYsWrrOYke8+W1j?=
 =?us-ascii?Q?sFQI/VulMYWSYwcUeZNTl9d2fDBmjPuHgmr8RGc4c5caslltpqDXFe3mS61M?=
 =?us-ascii?Q?5XSGPlLvOCgjRFhHieNvjkPhct4AcUbKcx0i27Ynp/Ae5dTgzCiR+ekS5Dxq?=
 =?us-ascii?Q?9K4AtVoOUE88W8jdykDOL3jkUS/B01hkKg7zyzAm3i8s8sYTCtK1fPBK11FG?=
 =?us-ascii?Q?m2Zrw7in2+A3vn0MtoUuwkCTJc+HGkIwJlkcTJkZPIbkP/4ydrv1rYz7OTRt?=
 =?us-ascii?Q?/SEOyXWsoHc6BaiwfwshJlcTsGqmvn7CjcR/W5E/IcEon/P3LHBL8UHey1oq?=
 =?us-ascii?Q?wE2vpWYh1Wf2Qtg4q1TRsCLTKqZX33HEkLtRCEQA7Bjd+LH1LODrzHVCqUVv?=
 =?us-ascii?Q?MbrbOzgZJJKRKTL7PYu5m+RBHsiE7D7J0YUt+as8cadlvNFoqhWRLj5pNskr?=
 =?us-ascii?Q?xvl3q/j2eOJLb9YFdLjCWGcmx5C0cgTOFu64JDdSyOb/Dtur7NbORXA3siNa?=
 =?us-ascii?Q?tbyfKvAUhGrpqjFy07GJIw8YCl8oFB+O/l1Ao8dt7Bk2SVaKUebY2QxAmQ6O?=
 =?us-ascii?Q?L+atNX2RUaHH0QUu7blW7kPVSx5raATlo/KqE9t6EMGMDNjSc1RlVaQR3tpN?=
 =?us-ascii?Q?ap0SnohM15Y6Ui4BWyj63r4k15ujFylpkDqysEYNUYmJSrWVJwscIJlryB3w?=
 =?us-ascii?Q?yZiKVsgQVEYUlz+AvPq+/dbuI+QcFNQfjfPZWMZQU7BB9m4iA1EDwSKdJJ9+?=
 =?us-ascii?Q?Vu2iDLiIjv3B/XSRW7XZiI5vz5fxft8qfD6Rq/2k8w7m0zL/8arvLQZyr/B7?=
 =?us-ascii?Q?i9sHvDxLO2ukJvr1b9YqkaZQO7JBnuvY953hsWy8pySN3J676DnPWrtFIu6U?=
 =?us-ascii?Q?bGkiOJa6D7RSzJCFVN86VKulvAgK1GS3JuDHudCzlzN4KUGCXYffxPdh9BiM?=
 =?us-ascii?Q?vxZj29516+oh0j6sZnNU0zGkW2QnymCEZjH+Rp6xo0RrnV0l6LpE7x3yXJ8Z?=
 =?us-ascii?Q?pJJ8zw9h7AQgLgud1sP3tLU4BiZsZlIt2TKS+WXeTSoT7N0lTpm6CrRTDuGp?=
 =?us-ascii?Q?79oSn9lhJcsZTL7b8tyl+wHo2GP6SQJModKPyL67EsARcQlYjol6YDfAQ0Vr?=
 =?us-ascii?Q?Uw2Gf2wVe+D0Nk2JKgu9OowGK4k6UN9dTAYAABofl4rITfrbYzf0C3iKhodc?=
 =?us-ascii?Q?owS+z+wpHnsV/ya9jYk5ygbifL4M+VHeN8/OZN/KwLPL56x6VMeH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a536c58e-f462-4b0e-39ef-08de3fdb801f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 15:21:51.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+d6yiBZIIjsGuNQcKt9uTd6yEnKwkxtmk3RsPnsHi/SCYXE/d/nbV+2fSa49hbI16bVpEFhB4WopaASXhRtMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2999

On Fri, Dec 19, 2025 at 09:39:37AM -0500, Frank Li wrote:
> On Thu, Dec 18, 2025 at 12:15:56AM +0900, Koichiro Den wrote:
> > The per-direction int_mask and linked_list_err_en registers are shared
> > between all channels. Updating them requires a read-modify-write
> > sequence, which can lose concurrent updates when multiple channels are
> > started in parallel. This may leave interrupts masked and stall
> > transfers under high load.
> >
> > Protect the RMW sequences with dw->lock.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> I just posted a similar patch
> https://lore.kernel.org/imx/20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com/
> 
> It change some method and I am working on add new request during dma engine
> running.
> 
> At least, you can base on above thread.

I hadn't seen it, thanks for the pointer. I'll read through it to base my
work on your series.

Koichiro

> 
> Frank
> 
> >  drivers/dma/dw-edma/dw-edma-core.h    |  3 ++-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index f652d2e38843..d393976a8bfc 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -118,7 +118,8 @@ struct dw_edma {
> >
> >  	struct dw_edma_chan		*chan;
> >
> > -	raw_spinlock_t			lock;		/* Only for legacy */
> > +	/* For legacy + shared regs RMW among channels */
> > +	raw_spinlock_t			lock;
> >
> >  	struct dw_edma_chip             *chip;
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 42a254eb9379..770b011ba3e4 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -369,7 +369,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> >  	struct dw_edma *dw = chan->dw;
> > -	u32 tmp;
> > +	unsigned long flags;
> > +	u32 tmp, orig;
> >
> >  	dw_edma_v0_core_write_chunk(chunk);
> >
> > @@ -413,7 +414,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			}
> >  		}
> >  		/* Interrupt mask/unmask - done, abort */
> > +		raw_spin_lock_irqsave(&dw->lock, flags);
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > +		orig = tmp;
> >  		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> >  			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> >  			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > @@ -421,11 +424,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> >  			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> >  		}
> > -		SET_RW_32(dw, chan->dir, int_mask, tmp);
> > +		if (tmp != orig)
> > +			SET_RW_32(dw, chan->dir, int_mask, tmp);
> >  		/* Linked list error */
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > +		orig = tmp;
> >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> > -		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > +		if (tmp != orig)
> > +			SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> >  		/* Channel control */
> >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > --
> > 2.51.0
> >

