Return-Path: <dmaengine+bounces-7488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B0C9F4EC
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 64E2C30000AC
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B52FE579;
	Wed,  3 Dec 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="N7fjQvtn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E21922F5;
	Wed,  3 Dec 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772598; cv=fail; b=LG+YiLwP/VBYeQTXVhukHn/0gM2LGiHs4WR4tLuM4EFPZPmQ4jqLL1tMvxwcQGSsgNtTp8BDq1Cl8lH4+3MIleihgL/mWF7fCuwQpN5OtllxC/Gbas9GDvAy+YHKjJNJ7LC21IsKzHrmiH5SRgh912SwSPly2SfaVkTHYsc58+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772598; c=relaxed/simple;
	bh=78t4bB//1pAgQor/KPo/0CCiTD+VtDXHkp0j4Rh8iqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gR3pwbs2hQZ0mRLsHxALoVH7+4U/3r+jxUeeHvNO3hXyGp3zjTItga1vAGPTUi9ldAH8buoxKUD7bZTb2IKyplCV5HDwuqfa292h2NfVTWQaIgdqnmVZ3jnaJbR9noKwl7RUJDowvCrjdd3gi5sLuuzH1uknSqgxrcarNmEWI0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=N7fjQvtn; arc=fail smtp.client-ip=40.107.74.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsYZKtBl6oeoEZwK0OSxe5lQUu2Z56U4CFkEMwWtT7LEqBULhm8b8uCS/b2pB0uXLlTzL3PKwvH7pe2geuUxS2fhA+o8jcfPURzITF3SCDVPXhc0NM9lHAlDH4ui9dP/cXVj+14S853gR3UQBf+0CoWtjPVKyL8nR33hq0InXjD6tewRT8OwZsbI8Nj+Ews7sd3CIiOk2xcY9InzQpciJ2S/hSDQiGsK5wg4EdWf0K/8BZ40xGdo14QNrn8hJ80oF93EsMwuircXMwZ3G0tJS/CIF3ONAiVkR6J5OAqWWjl9u2Db+ESTDXaAYYpP7vbOQUKb0nZduKHee4ugLgmx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPoA84T8W2Qbp92OnrkoI9nxrL1+6JxxzDEieQlhLXk=;
 b=pDwWdB1Be+JjUpQCmM6NXQbBEiViUgsbypfbjFur0MnGc1aOuFGK07dFVdKqSI5zQQ3FLFIyF+wqtizeLjAeoSfI5oyUJtBzs0YN3skUfAwno20XxbJBk28t2rZzhWK6hTWei2+3qPRf6B8xQ8rENcXocerUbRgjh5tnht5/3+QG0WyTlycXH5a41AJsTyPsExVrKq58bi8l0ChtQ4Dx7hOJAo6Cmw1Sd0b+XuqBqPSuUDynyvR0FkUzB4WsQEQKUGxkDeCAAwU0KhH33MunN9baMg5SSuF3kZABeWm4T4GRuOsBAjsY875pz2/Zjy6bzv2VQXVSLNJDl29MzbmALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPoA84T8W2Qbp92OnrkoI9nxrL1+6JxxzDEieQlhLXk=;
 b=N7fjQvtnxxLjuwxkyYTxwO7d/jcgZC4gbR0bdKMsoHaLumJEh9yEfwdIh61qIcq89VSiNwN3S3pZ3Vcs0qyVwZmoVHglToxH7UW7z+QeTAJn3kcnNhaknJzzpTLb88B5w1gKT27UeaS/orsLAf6HuRZ2859S62Do76qNsPlCf+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OSCP286MB5496.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:36:32 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:36:32 +0000
Date: Wed, 3 Dec 2025 23:36:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, 
	kurt.schwemmer@microsemi.com, logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, 
	pstanner@redhat.com, elfring@users.sourceforge.net, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <3tgotybip3qw66kyw23po2q63nuykajmus3dtjzs3rw2r34sxb@p47fj2m65kxw>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
 <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
 <aTATWZaiqwNfwymD@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTATWZaiqwNfwymD@ryzen>
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OSCP286MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5703d8d7-a892-4340-dbb7-08de32795a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRLuHnysxFI4eZVvP/55sMPIegUJ6MdHXMh9UsyDgSVHUgGTGD9sjdSwnrg1?=
 =?us-ascii?Q?suafjB8bA8uTH4Jq/YNfV1JwKSVUtXVZL6vZseNKQvUg/dptotX03CeYcUtM?=
 =?us-ascii?Q?YaiYY2qje7PmDeO+aoJUoNvFBhMp5mHqMBCpUh8FA2BIhEa7D6kGBrq+fKa/?=
 =?us-ascii?Q?wIdgsiTuW+v4q3Ee9KWQxbQFsyiOCb109zSjbNhP3UuX9ABweQ2l05KPPCYA?=
 =?us-ascii?Q?lUKvB1al9/blLO9/A9nHbZd4F2m73OnwnZ/IadlB7pXT2SzY6bb0BQ6/yvo9?=
 =?us-ascii?Q?0YMrfRM9KB1RFMSuaGWyERdud8k5Nvt0g+y92r3/dIoRy3DWQGMTKdICI6g4?=
 =?us-ascii?Q?LGSAVz1IXvJHAfFKvBEOuTrvhtMJpdXhzA42DEjI+KIlluX1srukRI5OMyu5?=
 =?us-ascii?Q?PQO4tgKgKofOyDJHrPyXEehoiSW6hj7ycwJzSBOxEUak1dMyfFoUCm5BiStG?=
 =?us-ascii?Q?86VauHwzwPZoCr+davHzM0+0yuUGUqTY6UQFI+ckgHIS5QsqKtMivHvox7i7?=
 =?us-ascii?Q?meJmqbljW/2ypJi58F9pPfM6SyNlHGSiucq6WzBVGI6zpIDHfiJnopxgNCO8?=
 =?us-ascii?Q?uwfNtQxPbMe3vcCOZi6p+lNLoi2VtjP9pS832g6xbol6OvP89eWqukpFjDJH?=
 =?us-ascii?Q?ImpIW3R/8j0+pBWCEnZVYqAPWr4gZy6xD4s0AQigXgmcngs8tRWhcVG6mSv8?=
 =?us-ascii?Q?vMQkM1VY/JL8d3b37+vqCrMGtoKQ6uwrqVm1hHisgY+b/ssUgBmVMstBK5vY?=
 =?us-ascii?Q?arLpH1HCdfjk8py/ayxm+tEbmmCo2BVnNCtd8EJYIqrOoWS5UKb8+dQWPNRF?=
 =?us-ascii?Q?otRmOD5t1gxfoQ/dVTwHnVxprV15QIWhAFwYcOg9php2vM1GjsLShe2pGYWr?=
 =?us-ascii?Q?Vw++c1JtZKNix2yB6CYpxW5tjG7VekrJvOXv+CbJJE2GPqbB+Y4BrV+CJCBm?=
 =?us-ascii?Q?WlhSwZ8UJGycHWD9RfDHw/LryJgu9vZ+eW4aenxDDBrQcgsy3DJF5V+Jsj4R?=
 =?us-ascii?Q?AB8bHQ+l3bZ6oxuvxd3ijXHHcsw6QYcVSxwQ9qU6RZHlt3EP2YwRGwuD3ApG?=
 =?us-ascii?Q?Rd1ltETlJNZi85dy8z+1XSTbnMsWf16eLzJ37s442TYF6fJsNNzIn9NgnbRP?=
 =?us-ascii?Q?VjaJ3M+zYae3lw8mJehTAgLqV77hH57V4J7ioNZNhhXyJFFs2n98lnwUbnBX?=
 =?us-ascii?Q?FsgqAP/op2ZmKhNZO+vCAtU7mUte0dNtSH7bjDkk+wyc2msrWmegUxT/C4AY?=
 =?us-ascii?Q?uodVvVqNHk92eQEKt0LNakkIW7Q3Z6RhrHKmFIsl6pdyfZrWGW72snsqEDft?=
 =?us-ascii?Q?jONtk8SsA3sri5Zmzn/ZkLU1KfMfWm5vKkepQ30eWbsxYd3AbMm4Ume1yeUh?=
 =?us-ascii?Q?H90DAnfugezCKALEvYxg9WObU15OHNdcybkVm5u7imrIl4gy3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5LQzdq8cIoxjhIbz71PkLe80MuyliBsWc3gQONR/jq2AP/LO3a+mPLDIQta?=
 =?us-ascii?Q?HDn8f0hDwcOSo/YF08wci4NLKecyd9rtLkF5nWjDwp3WIvI8NyMIZmeDOe+j?=
 =?us-ascii?Q?jgE47cj5VHcdU4ByPKCcaZ9s38h55T2EIz8iQDEYDgf07EKjuOExBbrSDsxU?=
 =?us-ascii?Q?Qmj/BzXCDQaYRkfkCP0OnIRNWUriwtKbqk4sM0IOvqYGWSuaGKP76fZDdV+R?=
 =?us-ascii?Q?ckDza8UswXPHv7iu71As0ieNsKtZ93BnEkTCMZuEC4xFa1QD4H6HEq+iRI+r?=
 =?us-ascii?Q?KoU0VjT5InVoC6QnU5HYdTt5KoOuqcwyZ1dFRLnRuoTuc6k39YEGyA/1X18V?=
 =?us-ascii?Q?UsstptnayVmXq0tozJi5BM37X2jK4cUnHqzx32rlt0gcvp3TNW/sJn9Kgt5i?=
 =?us-ascii?Q?40IDY1wz0ZJAgztmkNK6wZSezZrUehRWBUjwCLAWgcuGI60TiXNBBWI+9rt5?=
 =?us-ascii?Q?7MJEUhns4PMxFTH6ZAyALVgNA62odxsQFLX59L4MRE1JU9ZU9QJw+11tZt/o?=
 =?us-ascii?Q?EBJ0HQi3rmsmKtwgcKUh1NWZoiJHDzcGY7y3F1U5qdfQR0rzZF2Vo9cyGimi?=
 =?us-ascii?Q?YR36l44Ye3oNmp4Vq3QHS1yJ4QZdj8KmtlVrgfs1ckFlp06kVx/caH790WpL?=
 =?us-ascii?Q?32ZXr4K1j0qurmDs7hS2qmB4f++8T+KDoKznS6+b+f11qu2pxHEOIAfJk9b1?=
 =?us-ascii?Q?koFo5ec6JotrqU/W09UlVLaj7Bg11mXx8zF2av9hNIKuSD9G9g2NWhBanXE3?=
 =?us-ascii?Q?TSaH0yGmEocFCgPkNH0qhub2zpeur8MQ5EJXWUk4xe460YbZZgm9EjZRPfhV?=
 =?us-ascii?Q?1+RdthFNET0UIv3VBVaoqABq6+xm2MzSdONG6TaSV/qvTeLk3kJgfYjPSuaB?=
 =?us-ascii?Q?DYDG9fdONrMV3weiSzgMmPvdb8m2X1/nw2BLukcNxz3FkTZ6VJ6Whh9nGkoT?=
 =?us-ascii?Q?1Hf1BFD3hWRTzNQI+3A/h0LjDwBypqcqMw7MnN/CRhePlCVzA5bpkKfyy1Ze?=
 =?us-ascii?Q?5ZGkKCsd/Fi10y6NVGXt+16POxd4zWub8mICS69tyOXZDhodik31w2b+75Rv?=
 =?us-ascii?Q?aUm1TOP4IBi5wQXiVpSiZVNpHKFoG7dFJBJbhyzzV7YojfJhTvkXdr721h2x?=
 =?us-ascii?Q?PalCqvg105mnsf4vfp0zX5LhdcSOIeSWwmrBlKtb3D8VT/67iIJTQbP7X44F?=
 =?us-ascii?Q?hhY56fAAGnhs3lgUkZgj5oQM68OotqAX1gb7CLJ1l5yh/FspetJfedhFR6tS?=
 =?us-ascii?Q?YkKdWS+bqHuFSkSe5JGRIvNz8DkKKM/LS0kwYBMzqbftd0M2jo7Our+v73m4?=
 =?us-ascii?Q?ky/hxXnd3pyfW50D2Cd23P4BQDIJzuwrBilVLd8r4STdpdyoubvGarCucJuo?=
 =?us-ascii?Q?djWUydiMfKrqeq3UlY/fevd49NCEMgQHEuEew/c+suv0tYrvC0oS40X18kSA?=
 =?us-ascii?Q?qci6K2CGjuAl66+4AihcRqxCCAVB3gumcKAcqOJnGP24IYys4IXgvhPnzXM0?=
 =?us-ascii?Q?f4p2U9CU6xpgLvUt0Lsjo2HofAGYMuwXIFUgp5LP37u/Y9fgfCdGig/w+Tef?=
 =?us-ascii?Q?gd2HFtZWYYbWVE6ODaFhruE3jwPUkHVISp0wlXiT28jop3Ly9yvwhFHhswq8?=
 =?us-ascii?Q?G0kzwx8nzEdmY32OjWP9bSQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5703d8d7-a892-4340-dbb7-08de32795a9c
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:36:32.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1py7nPjxGOMMjuecFKWcFkCIZ7u+qhxvlwGC853n5GMlgt9fSc/ifF+wza+Ac0tWkRXvoQUr8WWqRLrpEtJivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5496

On Wed, Dec 03, 2025 at 11:39:21AM +0100, Niklas Cassel wrote:
> On Wed, Dec 03, 2025 at 05:40:45PM +0900, Koichiro Den wrote:
> > > 
> > > If we want to improve the dw-edma driver, so that an EPF driver can have
> > > multiple outstanding transfers, I think the best way forward would be to create
> > > a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> > > does not require dmaengine_slave_config() to be called before every
> > > _prep_slave_memcpy() call.
> > 
> > Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
> > thread, be sufficient?
> 
> I think that Frank is suggesting a new dmaengine API,
> dmaengine_prep_slave_single_config(), which is like
> dmaengine_prep_slave_single(), but also takes a struct dma_slave_config *
> as a parameter.
> 
> 
> I really like the idea.
> I think it would allow us to remove the mutex in nvmet_pci_epf_dma_transfer():
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429

Thank you for the clarification. I was wondering whether there were any
particular reasons for covering such a broad window (i.e. from
dmaengine_prep_slave_sg() to the end of dma_sync_wait()) with the mutex in
the nvme case (but it seems there are none, right?).

> 
> Frank you wrote: "Thanks, we also consider ..."
> Does that mean that you have any plans to work on this?
> I would definitely be interested.

No, I only learned about the idea in this thread. I also think it is a good
idea, but I would be interested to know why it has not been upstreamed so
far, I mean, whether there were any technical hurdles. Frank, any input
would be greatly appreciated.

Thank you,
Koichiro

> 
> 
> Kind regards,
> Niklas

