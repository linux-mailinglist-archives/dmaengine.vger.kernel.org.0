Return-Path: <dmaengine+bounces-7454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD5FC9A4E6
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B693A2527
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468921D3CC;
	Tue,  2 Dec 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jZSlqLCN"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32601AA7A6;
	Tue,  2 Dec 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657078; cv=fail; b=suAnpHNdwfLOF3IFHKigHo0yz66O/BlhYD/AqGAliz2P6IOB8woPFsSBXQPLDP9UOU/RPPy9zRpURRpVk3E5sTXtjML7H5Y7zCmw38X2padpdok58MtM4dnqp7zhoKPQ+rf8NAxLZ0N+cvqeXjQuvVNMvqXsYPri+F9nFakNUls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657078; c=relaxed/simple;
	bh=V5/G7E/z4+kBipSnXiyBh5aNUzAC2ISsqNrBU/me8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZNw0DxAEa2iU6Q1/VK6UHOcXBIMc/7JLkU0FR4VCU9wbW/1enpQiU1J8I1Ouo+0no5E1JioeLOMGwpFcx9vklQPppcrS390rGzwyk7Y3fb8mzXsOq+FezRQExkMdlD1dwos1J5OU6NwT+LA5y0TwQumsZ3wK2Iw18/OSPTcFq1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jZSlqLCN; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N41nZgSDAzyrrUv+CD1iHEJfMzQ7T9/+dUWu2atR4/OPSUjV43uAkLbIDkqL/f+9zDq/E81yQRhyKVMZkvF/DxLZkivzAlxAVvmd2q9BGfaVs/txIyEQdWBAVMZrAhQIsT8rG4FOJhGWmrXp+Dvk7rRwtPczgPzUjXu2b+wykC1r5mStDwMFPnlh5irrD6HfVrrDH0IGjQWAmwxv4TadU96jYl20tqpZnVbtwtVpVSdFvStTgqTAPXj/e2/1idAC9Qtl8vwWfGfEDeAUqhC3VMefzE04wzncC6fHjO6O3bpe8UDlg+hIX24idbv6XfGWoYrGDNOUakvUeQn7fRStFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ko/YYXm78MEpAAQ3iFSSUHP3VlQtLYE462pQCzWCic=;
 b=EPQWdPElpDMkwLpIqE4sa9/GvpjZGQOyU1gkwJP7eCk/cSU/pK9NnXRoJePxkzlAwx2H2cpXVzfkZaxd7NZkKgav49uF5e9j5O8gHQZvoTfqGahZ7dhZuQRMe4fFpI09SlOBkTPr5Ufpfxl1DKYgE0e37Caou4R8X8FtBIbriSCYIALr6XfHt7hVG4kZAxWocwTR5nMRtab/YPhbA/PuC52Lnk5GX6Ep8aDlyA4sTiegYitObpY6RpERuPGhZCvVt+v/uvCnhBWIjhM4OVJpAGvHWtmGrf62t14JJmONQ5YgzOF1GSK1poGsEyktIrhCb/C71pipf9wHfvI7fDNpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ko/YYXm78MEpAAQ3iFSSUHP3VlQtLYE462pQCzWCic=;
 b=jZSlqLCN0ESV1NnGxjTmMOH8szJTuzMa0Yt1G5OYzZXeYZHRzci9zUNGLX2jMGkjqVeIDOu0KEk5i9MFl8A36JXQtYvnaOL/2iFlOcGZ79E6+6neBjx4kq+dIGGFma45HuDCfAM9/Acpm6PaiGd63tmRBIMGdG5uR1WoFvJeTTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY7P286MB6868.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:31:13 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:31:13 +0000
Date: Tue, 2 Dec 2025 15:31:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Message-ID: <ode5invb5ufpsus6dtmpc73fxoe764joqd7jpamumu7m3rkzvw@qn6d4xtsco7n>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
 <aS3u7Ub+yY1oWD9i@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3u7Ub+yY1oWD9i@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY7P286MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d58620-9c27-4ff8-06ec-08de316c63fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/SAJmUOA0PoSSqfQy0+K48Qw0pWdPGXEEbpYxMcMFEFv1ccsJ44OnLifCPo?=
 =?us-ascii?Q?yPPOCBshN7ty9eMkS6RTyN7eh9bhmMa+jwid/T9c2Gn+2uiklGtTi2UC6IEF?=
 =?us-ascii?Q?EV9QF6BLXEIjXkFEJDZOZntJxv+Hm9wLFbMXPWdd1nkwU+UpZ5ntB2zZ3c6H?=
 =?us-ascii?Q?JRIfWbaYc3ABXG0LBBNOLzAAUZ33GoUrgRuF2FSkH14yZKFrN83iYkUdtktb?=
 =?us-ascii?Q?kBjAFu86W2QmOU9jK7HSru2Nb1bEDoKcjyMhACN4rNydPG5P/wIR86SBGHMV?=
 =?us-ascii?Q?/jCdF5/rUZmg7nhTbHKeIF/Xq6FBk2doaR+OS0ahXNYB+IeXWmOIge9yNTfU?=
 =?us-ascii?Q?SNkKJ7Hc1eHP9cKLNIqN+FSe+m7Ps77HWqsbl0DO4+pzuTxhYwHNce9Ja1U2?=
 =?us-ascii?Q?hkv0gArrE0/G0tInA99C3Ta5+XtIZ4MNIDbVTT+V04CCS0bZe8+uixT5b4nF?=
 =?us-ascii?Q?If/2JGzIweu6zivu4Owf1mkitLaUlSM9zpzMp6msxEZWFK8IsVpb8xrhBQkQ?=
 =?us-ascii?Q?PjAqhtaSci8yTDX/l59OshDuXDSg3IZr9w2vWmb9PuZBaKkN3sUIW+GKGcqQ?=
 =?us-ascii?Q?e3jIQoNjDo0JDMEjzXYccD9mAwrwrOIcgYc5uZuWJBUWS6hglJq3x8dZVdvH?=
 =?us-ascii?Q?fqIWan3jBuJQFWVsVMunnbUXi3YMxSva/XbCreB24A2eF5dwuCPhetRxoaW3?=
 =?us-ascii?Q?aouMoAHwHvYmzFZfVV6goG8duslur4/igWmwzVq1Pq3qAbXPGLL7jNl+a7c7?=
 =?us-ascii?Q?Cd5Xt1PqPXe5gVF7Jfjk9ghHxvObFqkjf5NtuBbuDcOSAFzqxR02g8yGQYmW?=
 =?us-ascii?Q?JkeHkP7Ccj+Iq91BBIac4vd5cNqX77Ac8ozQZXO0EvcvAhDWankESEI/mRYZ?=
 =?us-ascii?Q?IqPSnqfVxKX2PCXVvpPehJcJ9p1o0/H0K6wAHiWRPiOWrcnCUYIUR/o5zTcX?=
 =?us-ascii?Q?FKvwC5T/zurWBBvBTrcSukjBJV5RRczd1iT0+QuddW41zcxm1NDTkRb/l/PL?=
 =?us-ascii?Q?4+EdTOp6NPpI0RZH6qpJ84KSxnQUt6dN9IDAsxvmsHEjWtBt+/3FXdZlBqdE?=
 =?us-ascii?Q?ws5ANvSzwVPjza/vcA1HoeL72bw5teIORGjj9pYFY1HDkjm/yObBb9HTaaAf?=
 =?us-ascii?Q?NcDm8kGhJNOyiNhXaipJliuIGAcXfkCXfmJg6TQ+3xFW96sIdN4S7zl4Q87X?=
 =?us-ascii?Q?2SN6j82NWhyrjYQCGOQTy6d/ykubmYqCHrYt78XnXwQ51yu22RxDpknKNIUL?=
 =?us-ascii?Q?tJNdWqvA0KYCBe5s14Crhh7mS2eCObJhHQJBCmQ1xYQ1Bh1/cepJYoaXv6Hz?=
 =?us-ascii?Q?IGhPl6fYaL3kFnZkaM1EVxJpn1e41JxY8IT64FuV++0RXVFawKTF1N+0kxRI?=
 =?us-ascii?Q?WmuHK/PlBjt6P0NUXZHQtiE4ergJdVWoSizaAwPgl8roF9KQ1xZ1uETl+sWL?=
 =?us-ascii?Q?mGcRoyaN7gA0xQ3vXud2F4v7CK7XmPq3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaSmGhIjxxernXMglWpVXKotr0SKUzfimuRgPHcfkLy7k7RVYcDCLzNcnYDu?=
 =?us-ascii?Q?LmiWbhkQUlnODeiXykQZOiIy/gQkmkm8L5oeBQBOduIHXQ9jAAvvXCUy6Iuu?=
 =?us-ascii?Q?LhNWiP5Sv+vh8VGqOZv8tLX338CHVfZyT6FetizfzOMcdPX82EuotRJgBpX6?=
 =?us-ascii?Q?UVn0yymnl5oE9k6MYt4dVRQlacP7K2/BOEh0Jr1TTgnkUjq4ylq9xR1jU7uP?=
 =?us-ascii?Q?vdr5lhQY/EkvnyBXJ3OSzxd3svdtiWcO0pEiFHU0uxSWAzUf9MvlTaTs8sV1?=
 =?us-ascii?Q?EEgad2ljIr9pgpUjId11Vagiazff/9zVG0E0rLkuxyLJ8aVhse6UQ5fe+Z6E?=
 =?us-ascii?Q?0R7HWDe2qaVJU5a/MKKMvODZU9Cy9kRUAPsaQLKmAMdKYsbTYeX7SLBMjue6?=
 =?us-ascii?Q?9MLk9S5EAFViHGpE5bcTvFLdRRlQRf6kmoGeHatMwoRiA7ZXIzS6yyu29oNU?=
 =?us-ascii?Q?DENv0U0Uv4DxqCUff8FXUv7S80Ij+QH8oKGWytr3gBkHLVNV/leCIRv9WFAz?=
 =?us-ascii?Q?91/QDU4Fdhn/jws3nlzy/9Get36O8v35k9Wnhqwr3d2h63sPKjmgJh/jNdrX?=
 =?us-ascii?Q?Ecu5yJw9kpxSHwbUPgThuva1++3vR5R7+5df042dxBNR/+bRGp2ut+ynzYMj?=
 =?us-ascii?Q?SoaOPcB6aaA9lTiTEYXxAm2Q/piNWjxoHuen1PH7y6DuNQkMBP2YvAi+vphc?=
 =?us-ascii?Q?ShkDy0bPCZ64PLldV/Vl7Fupua1pLKeSkt8xBoJgtHbfWGsWHlkM1avZBO/E?=
 =?us-ascii?Q?4QHoFoeA+N8++LTt/JLo+0iTDim2fmUS8Ou/m26eBa8kTwIbqiPLFe9iQr9f?=
 =?us-ascii?Q?4JcQYDt9IKC1c1BBxQ8mzP4KCVnwM8J94TlbSZiHwoTPnMW2mmUsKuP+hDRD?=
 =?us-ascii?Q?SrzR7U0U42257c6YpLBZcuuy0fU1mQhHKCciJoMiL7FF+m4SifXps80XE4yU?=
 =?us-ascii?Q?svxNsjXssvbZG5yYgF32b5RNNiupnldR8DlWtH+tIn/tJBt6qeEgD28wUDiw?=
 =?us-ascii?Q?wWlqdZRJT8jENkJ3e0AVWaV7XrbMc3v/hkj/OByBdmz4NeFUDu4CD4e9fhwD?=
 =?us-ascii?Q?qlSyZLsER+1BL97ZN9x4/wZKmNzl3ZndqBiSawsVF11NVu8ilTLLvgaIgP6M?=
 =?us-ascii?Q?L5xUHVch3CzaIT5QaY41eXTwbcKFrzDZbXTXuDyLtwnZY6ZI7BjkxRZGL1DY?=
 =?us-ascii?Q?IXceG7WJYccaazz9LqypaZ39vO4Mo3MoYlpexIYs4MG1Y06cdYwpd9pwdKSh?=
 =?us-ascii?Q?JOhN2qB6+IH2+8fR79VOpgTuQHzS/H1NrvrIvwSAgBbd8TcnI2k4sad2bW85?=
 =?us-ascii?Q?t+C/CNlOogItANtg7TlMXGEat+sDUmR1cCqEqjaJyFGAqN018RA0+D8lUOsI?=
 =?us-ascii?Q?/+I5171KcyTatS/2W4pAqW2eq/37inUAXORBEjzIoa/NBIE+qqXaj3slIsgD?=
 =?us-ascii?Q?ZDPQjLzHd+nqxaJN9v1fqaHxGGdKlU9G+Qc0MU+LKRP4G0RdxSquLG33r2pw?=
 =?us-ascii?Q?fM7v28mtrU7JM9fGW/B4cZrc9j0nN50axxXltXihkeFMZWnkNs6wVWRFuQY5?=
 =?us-ascii?Q?bj2bhyNtrIQ0G7cxW4U0tjzLbcqS98JNc9MLe/Mi/L4ZgsixesUrFtisAa6d?=
 =?us-ascii?Q?J4rX8Iq+8ibHW5WsrFP2DaY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d58620-9c27-4ff8-06ec-08de316c63fd
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:31:13.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3zEv3lenFJx1rOsUlsUFgiiML3Oe9YtOHYEPYKzb4uOwVAaP7njcq173SyMc31Yd0ONINm3/1nJ+YwxslI+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6868

On Mon, Dec 01, 2025 at 02:39:25PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:48AM +0900, Koichiro Den wrote:
> > Add an optional get_pci_epc() callback to retrieve the underlying
> > pci_epc device associated with the NTB implementation.
> 
> EPC run at EP side, this is running at RC side. Why need get EP side's
> controller pointer?

Thanks for pointing it out, that inclusion was just a mistake,
I'm unsure how it slipped in, I guess I was naively trying to get rid of
'enum pci_barno' by (ab)using pci-epf.h, which is unrelated.
I'll drop the changes on ntb_hw_epf.c.

-Koichiro

> 
> Frank
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
> >  include/linux/ntb.h             | 21 +++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index a3ec411bfe49..d55ce6b0fad4 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-epf.h>
> >  #include <linux/slab.h>
> >  #include <linux/ntb.h>
> >
> > @@ -49,16 +50,6 @@
> >
> >  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
> >
> > -enum pci_barno {
> > -	NO_BAR = -1,
> > -	BAR_0,
> > -	BAR_1,
> > -	BAR_2,
> > -	BAR_3,
> > -	BAR_4,
> > -	BAR_5,
> > -};
> > -
> >  enum epf_ntb_bar {
> >  	BAR_CONFIG,
> >  	BAR_PEER_SPAD,
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index d7ce5d2e60d0..04dc9a4d6b85 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -64,6 +64,7 @@ struct ntb_client;
> >  struct ntb_dev;
> >  struct ntb_msi;
> >  struct pci_dev;
> > +struct pci_epc;
> >
> >  /**
> >   * enum ntb_topo - NTB connection topology
> > @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> >   * @msg_clear_mask:	See ntb_msg_clear_mask().
> >   * @msg_read:		See ntb_msg_read().
> >   * @peer_msg_write:	See ntb_peer_msg_write().
> > + * @get_pci_epc:	See ntb_get_pci_epc().
> >   */
> >  struct ntb_dev_ops {
> >  	int (*port_number)(struct ntb_dev *ntb);
> > @@ -331,6 +333,7 @@ struct ntb_dev_ops {
> >  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
> >  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> > +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
> >  };
> >
> >  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> > @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
> >  		!ops->msg_read == !ops->msg_count		&&
> >  		!ops->peer_msg_write == !ops->msg_count		&&
> > +
> > +		/* Miscellaneous optional callbacks */
> > +		/* ops->get_pci_epc			&& */
> >  		1;
> >  }
> >
> > @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
> >  }
> >
> > +/**
> > + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
> > + * @ntb:	NTB device context.
> > + *
> > + * Get the backing PCI endpoint controller representation.
> > + *
> > + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
> > + */
> > +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
> > +{
> > +	if (!ntb->ops->get_pci_epc)
> > +		return NULL;
> > +	return ntb->ops->get_pci_epc(ntb);
> > +}
> > +
> >  /**
> >   * ntb_peer_resource_idx() - get a resource index for a given peer idx
> >   * @ntb:	NTB device context.
> > --
> > 2.48.1
> >

