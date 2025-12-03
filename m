Return-Path: <dmaengine+bounces-7487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84396C9F43E
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F503A2B12
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAEF2F1FDA;
	Wed,  3 Dec 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QnXyN2pU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011066.outbound.protection.outlook.com [52.101.125.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2122DF9E;
	Wed,  3 Dec 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771575; cv=fail; b=ah5kjfJX7WY9dEiYZX+CzHxQCSH842RNy6BPgIlF4r86mquwCAjokgZow+kkyMorf07LTxvBLtQiyEpDmk/Lbb3og08gCmtB3iDnIAdON140U6a7NrBSq8E+tBPiPch2zYu2sPOnGMSQXz3cBApBDaJuzE5WzTJ7xPdglyqeAk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771575; c=relaxed/simple;
	bh=vUx4+eNj6D16UE98J+WzZgSkdl3iHZoEetqeqyBOyJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zgzvp3uJ7tiMBlj+uLdKkViRxtDg5vvRPWraz3hLNVZoZ1TkXwtsrqZ3UWy9rnKn1YtZgLU+lQNF81ymBuk55o62bkxlcEjmHZrOIfHMJn8uDfW5tRxxQO8j7r3T1GewYbFsGBlNkK6lSRFZgLddzqfiDQ6mv3BzjUMn417K/cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QnXyN2pU; arc=fail smtp.client-ip=52.101.125.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAtxqD04T1nhhRIOCSXx0zZcfl6+bHFskjRwciDVLvDtmCR/4kU7PBrRp+zCm+6UutPq6IQd6g9wSkSOMwmPGL+e+Jf9K+hz7CUgvMILFfSWt4l1Yb9wzJIssd4FUptQ1wcq5fuyLJ/IPGLyFl0EGxKMzidnfzzJ2sqOMspIH0vJjyNZiidLV5u7eIcfFIFi/yTnnFR7FQV5I/Yjw8pPr2ZN2gZTrQheaWZ/spzONAOQaklNGkAulymYaz0RZS308V3sexQaKCDqW47Z74dGPL9Om+fdWqsOSDS5r4FGRI3z8l/rvrEuGR4CIlSCbl6ZAPlVd+Ik9H0V8N2TA1eR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijV8qCxVqyOMmpLSoRPJoA4QZdWJx9PnoEG+fb+txDM=;
 b=DrsnEeAhijtAwT3fJU60oJHVB6U6Xt7RP3uNCaMnKk/TKT5ORPEMd7UX7/5RN97uY7FBvywIYxNIJ3WHznpqb3/gBCvsly8yXH0h2U9lio5MN8I9/BFzsiZ0lRlzjlSfRI1cfUeIetK5l4okYmZ1XhLwT2qPfDreCmuYyrMuVbAYdrhiSFcCozAi9xnuU17h8XJFaFJXpm0BEmHq+rt0OtGXXy49iLAO9b4ZGN1/HslZ+b9pAmqqawAYCAbQ0JmAeaf5ikBmlqSN7A9wskn0AOP6lXyKar3RCf0Pg26JLWZijug4y+GSnxIyMynQ9JZamWn9H0tjSqJlR3nORvnH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijV8qCxVqyOMmpLSoRPJoA4QZdWJx9PnoEG+fb+txDM=;
 b=QnXyN2pUwD6oq2mN00tFrwTwh0voESJRLrTwoq0TVSWVB+0R/T+KX16ZG/L9r9hlI3Sn3cABqzdV2toiwwhOuYp+FtPt26AGnIoXetkQ+FCZxYmiqSNzGP+FHulydHJhBbJUrDllXDnSGT/0ptibajxBtRXmvdJS69tUl1cOQF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB6117.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:19:26 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:19:26 +0000
Date: Wed, 3 Dec 2025 23:19:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com, 
	fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <zherm6igpxilhkgkt5pbbwbwbuka6axp7mv6tzg5nz7k2oyiep@lthjpzxvkvcv>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <c3478f9b-9f49-4953-b21f-28547ac90d63@intel.com>
 <mh2guixk3r5lopn7zu2wy5oywtyympt3ppbofy3snz6iomd3al@kuoybva4zriz>
 <14619020-8c56-473c-a1a6-5c5db2431a32@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14619020-8c56-473c-a1a6-5c5db2431a32@intel.com>
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 636ea87d-bc93-40c6-dbfb-08de3276f6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|1800799024|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmRyZl6kQv5D+StTkWeeNdFL+4TPi/wmLmNKLKkoAPx6nkH4nwOIcTP1hnq/?=
 =?us-ascii?Q?+RSqm8yFBu76MQG0wRtlg3Xj7cRfYHRtPJNpiPouygwMDkV6hak156q8M9pK?=
 =?us-ascii?Q?YebDw90sotB046qOFuD6TAlcG5j5+uaZtiJToA95mUkMkdls4KkmnJ1zn/5A?=
 =?us-ascii?Q?W/Tdo3t6ko+OLlB6XAjlK+Zbq0pR2jP8cDGNQLaqGPx6ZU3Zt+nMIkKW39kW?=
 =?us-ascii?Q?u3M45p8PvLOtdnUSk4DXtmSWdwbJ32Fx0BaOWi0anPO7sKiiiknXuADO6PXg?=
 =?us-ascii?Q?7UbmYxYkXeyhBNqNnHbuj+RS5zIZKBEq2IaOrSb7Emz07HgId72LYiFZIDIv?=
 =?us-ascii?Q?D5rwVt26r0rRranY7i4HZnZkeqQQ5S22OdfuPUHUjOHSqVTpCTjRBHyRQr0T?=
 =?us-ascii?Q?QQzCSeXxskv5Ozt6BlmNq8u9JYrfPEo4H/zoasOQ7utowipWOdIBPQ1+2wIm?=
 =?us-ascii?Q?iyIaDNG/QCX6rj4j2blrRv+x13fRsue8uadb2yuwmcI+SW8BsYrYeGfQhYNL?=
 =?us-ascii?Q?6ivZ49Kr87Yf95EMezNHfb0FqGSNghKsnn5SYPdd0dMIQ46kW2OJf37Q4Q1z?=
 =?us-ascii?Q?wGhAGauPlBPkps+zPS/QHCnnX7tgQScthBlAjWCHSRi+P9Kch2o9imCkY3ng?=
 =?us-ascii?Q?XPlTLgso4odIlbJ/JQYTY0jFDlxmTZ7z4QxPbrj8IhZEaNUuYUDDTYJoYxxE?=
 =?us-ascii?Q?qeo/ESN84A11VezSSZyhJy2GhxWuEVqUH4vxmFVvyrIwfEPav3yuA3UdiY2P?=
 =?us-ascii?Q?+lA+a2l+MfiHE1ntbxMaDNyVdihQlmIHtAMLwDmBWbhX7piOzP0Vd14aEE1T?=
 =?us-ascii?Q?YyXaHG60hRSzA6qqo8tyYSSOVKpeTrUTsBRQqKd1e2DJg1OoxTfs6XNqUva9?=
 =?us-ascii?Q?AQmJ0TB9Sb/b+ApZlSTUSXucv2of/rXA2d3RuuOvkLwzZa6yhubrI70mypdl?=
 =?us-ascii?Q?NXcX/zy9JPWuycdFSWI+g/3Ksxbxq1rWGNXGRY1UqVlVog+YE9beZRnDkJTF?=
 =?us-ascii?Q?RgcmKzV7cL9Lp7XzcAJXLcp+XNp+95V6beG7YPhNiTQrj9MUpgsMjOnfT9i5?=
 =?us-ascii?Q?X0jAL4Y1s/ZgUKx6kv+VRjFPN+oZffoFCXixyl5wzs2E0PJqwZj/fOduH1wz?=
 =?us-ascii?Q?kgIe/yAZJWkeqCwuN4iNyqbcNNobSrRftuzEkzv/U9y4+78E2ZF4mvXug1V1?=
 =?us-ascii?Q?EfTJuHKZ34xmoDcyzwvI0ZEsog9oOOT+m6YP0aAjBHXDHSyfFFo3v56Qae0F?=
 =?us-ascii?Q?LGy1GcRWgjofFK/NE9EwC0XvQwvZpBwx54liywl4lxUM8ihUDfQbX2fGvm7W?=
 =?us-ascii?Q?RCTdf+1j8TCqPvfvd/cnPbzVF0jYhcpx53J/BI+PbBuMhtgvletYLrDcuj5Y?=
 =?us-ascii?Q?ukF+2Y8L+hJIzilDqPZ1vx5f8WOw2/f3tsF0O+I6IquL19QKzAl3QYylbcjC?=
 =?us-ascii?Q?t2dt8T/JN5YiF+aaRpIaXMa/NyE+9aoPZMrD0Nh/y1tOoL5PcE+6ZBUoOUDA?=
 =?us-ascii?Q?odpL7wJnhz0x2I0mV7FkO+bSfNi+UWptIqIt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOGeIURxHWG6OpasFt2X33+IZ7vAIkjNOwclfeYpjHRHK5CD1XBBhGCFTMpT?=
 =?us-ascii?Q?E2WggIKciL+BWYo+xIMLrTG3HHiCvpaR8v4M8KFGOwWouO+TMzTQZRKAKBDp?=
 =?us-ascii?Q?AGGKY/n0kxmB75OS+/DFir9foJQ8g/qjbC3xkvgf6CBb2B8uWdbAYU/iPyl6?=
 =?us-ascii?Q?53EqsCNkKui4vzA8JuMLhFxOjOjE3v8y68Yb7E0d5sMdvA+l/xuCf5WFba54?=
 =?us-ascii?Q?Qc3/UmOi6mkmfo/ZXAv8frO33EhtTKXB69dqStOAZTVi1PJ+c3Nyd8He3nET?=
 =?us-ascii?Q?c4G2AOjOo+QWPppto/QJ+LrpGxm5qc0cOZTqUPpp4+4hWRpfseEcOy3S2OR/?=
 =?us-ascii?Q?op6MX9JuLQRPuQYPE6OgSpnj/1fMh3z7jsd05vK7mkdycli5FOthTDlCZrQF?=
 =?us-ascii?Q?tyWCJbRdFEwB5B/SvmJ3LUQwKPWFPNw0+iWtEeyP3qbOeQl86tUbUhxA41lv?=
 =?us-ascii?Q?P1kX/xbUH89SklDg7KsAXGcUywlzCIq16+t3/MP1l/Tj47RL2WrpY1dhp/v/?=
 =?us-ascii?Q?nuqJdJlLD1xYSecv77feFaEjqGXoc32oqE6tDSPgZtx3Ur9iCrGx4pNLhUZj?=
 =?us-ascii?Q?JnZHN8lISWj3a1XJ4z/CZqX+bxaQV4JpTNRr2oKtwS+DUQ2x6HIw+DliVH/G?=
 =?us-ascii?Q?yiuOV3uCq7ZmxLtmD18XDJm0d+KbrerpGZyCL3WWgBAc4ukFsd339fINDdiM?=
 =?us-ascii?Q?Rq/+znw3LbIgney6RhNVc4ghRK406rr+ulty5VraYnLB9R8WUin0VsdM5VA5?=
 =?us-ascii?Q?fGBCSKMLWp+i/KPc/COabnxUtreuvWAgr+YBguYB1IaUO3pA/c09kModpaQg?=
 =?us-ascii?Q?9wXYKtHhcXD8YwRU782iSeG3mYNn77al7TY9ziXr0l7I9ZNwwAsg5DbXwVMW?=
 =?us-ascii?Q?mtJbn9SP7FyRO5VNYGNG9XS7c4Vt6bxvn6/Rr7qK4ckTiP9KW3jhUTg7XUpg?=
 =?us-ascii?Q?/ZnJ8ZLe756yTrEgOTFWp5Kh5AE0QGnElDlgNr92ojIwhyObCGLIyV042LZl?=
 =?us-ascii?Q?1vFbNEQB5IcPS56u5u8FGvVvfZ8kwoaYU6flQEAQWRR603KQ2oM8VCgrZ0XP?=
 =?us-ascii?Q?Yyu8yrBV5fbh9joZOeIWvN5Wnjgwph1dI2PMJHhm7PPgoqS3ePfDy/Xm+UPr?=
 =?us-ascii?Q?xKPtHNjwSRWchs5p4KQYzLhMwdB5nCk5XfN/rWX/UOmjpOLhRg+0ZmsNDmlE?=
 =?us-ascii?Q?S6/AY8Y3n/cPNMC9NXl/ihZEGFhseSXXcp1nXm4qe1QhJ/Ys2oAz91cCxk8e?=
 =?us-ascii?Q?25hI8agPKqC47u5byKdoaKTsbCY6RtP/n3XaxM0ebIH6C4oh4Wty4uWS5jRx?=
 =?us-ascii?Q?WZr+BvlalRhyiOtx/qihQaV62HyPkisSAYnctPcCdx4ufxmPEu7JAmA7Uf13?=
 =?us-ascii?Q?gUkL8nOvt28mYYFmMzhm44NDNm3yfcG+yqggswntKuEwu6oJk4AX/5DvI6Nz?=
 =?us-ascii?Q?ofrarjFTVeQbGMTfI4nriR/sDqOaMsEac3lYWs3jvhdNWWu1WyJhQ3ve1tFl?=
 =?us-ascii?Q?n3fq/B4I8Pzw0h9hwcr1C+N5WrE0TruO0zJ82tRENUI3Qy/gM1qyZT5hyAEi?=
 =?us-ascii?Q?jaMM+PMSdUyJS8sjE75mL5mLAcsCu8zH3GUS48eeaw3LOVQ0LDakK4d+xQSQ?=
 =?us-ascii?Q?yOzYG1pBItdYiF1Ma7l9Yac=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 636ea87d-bc93-40c6-dbfb-08de3276f6c6
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:19:26.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljdsciREbFxIQUZCUt5KbOUon4cG0l9VAzK6JN4sH3msYsQojZhkpQdIQvzsPoSptLtABWC4E825wt7wXNRIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6117

On Tue, Dec 02, 2025 at 07:53:59AM -0700, Dave Jiang wrote:
> 
> 
> On 12/1/25 11:59 PM, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 02:46:41PM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 11/29/25 9:03 AM, Koichiro Den wrote:
> >>> Add a new transport backend that uses a remote DesignWare eDMA engine
> >>> located on the NTB endpoint to move data between host and endpoint.
> >>>
> >>> In this mode:
> >>>
> >>>   - The endpoint exposes a dedicated memory window that contains the
> >>>     eDMA register block followed by a small control structure (struct
> >>>     ntb_edma_info) and per-channel linked-list (LL) rings.
> >>>
> >>>   - On the endpoint side, ntb_edma_setup_mws() allocates the control
> >>>     structure and LL rings in endpoint memory, then programs an inbound
> >>>     iATU region so that the host can access them via a peer MW.
> >>>
> >>>   - On the host side, ntb_edma_setup_peer() ioremaps the peer MW, reads
> >>>     ntb_edma_info and configures a dw-edma DMA device to use the LL
> >>>     rings provided by the endpoint.
> >>>
> >>>   - ntb_transport is extended with a new backend_ops implementation that
> >>>     routes TX and RX enqueue/poll operations through the remote eDMA
> >>>     rings while keeping the existing shared-memory backend intact.
> >>>
> >>>   - The host signals the endpoint via a dedicated DMA read channel.
> >>>     'use_msi' module option is ignored when 'use_remote_edma=1'.
> >>>
> >>> The new mode is guarded by a Kconfig option (NTB_TRANSPORT_EDMA) and a
> >>> module parameter (use_remote_edma). When disabled, the existing
> >>> ntb_transport behaviour is unchanged.
> >>>
> >>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>> ---
> >>>  drivers/ntb/Kconfig                           |   11 +
> >>>  drivers/ntb/Makefile                          |    3 +
> >>>  drivers/ntb/ntb_edma.c                        |  628 ++++++++
> >>>  drivers/ntb/ntb_edma.h                        |  128 ++
> >>
> >> I briefly looked over the code. It feels like the EDMA bits should go in drivers/ntb/hw/ rather than drivers/ntb/ given it's pretty specific to the designware hardware. What sits in drivers/ntb should be generic APIs where a different vendor can utilize it and not having to adopt to designware hardware specifics. So maybe a bit more abstractions are needed?
> > 
> > That makes sense, I'll reorganize things. Thank you for the suggestion.
> 
> Also, since a new transport is being introduced. Please update Documentation/driver-api/ntb.rst. While the current documentation doesn't provide adaquate API documentation for ntb_transport APIs, hopefully the new transport can do better going forward. :) Thank you!

Thanks for the reminder. I'll update ntb.rst in the next revision (perhaps
as part of a split-out series).

Thank you for the review,
Koichiro

> 
> DJ
> 
> > 
> >>
> >>>  .../{ntb_transport.c => ntb_transport_core.c} | 1281 ++++++++++++++++-
> >>>  5 files changed, 2048 insertions(+), 3 deletions(-)
> >>>  create mode 100644 drivers/ntb/ntb_edma.c
> >>>  create mode 100644 drivers/ntb/ntb_edma.h
> >>>  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (65%)
> >>>
> >>> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> >>> index df16c755b4da..db63f02bb116 100644
> >>> --- a/drivers/ntb/Kconfig
> >>> +++ b/drivers/ntb/Kconfig
> >>> @@ -37,4 +37,15 @@ config NTB_TRANSPORT
> >>>  
> >>>  	 If unsure, say N.
> >>>  
> >>> +config NTB_TRANSPORT_EDMA
> >>> +	bool "NTB Transport backed by remote eDMA"
> >>> +	depends on NTB_TRANSPORT
> >>> +	depends on PCI
> >>> +	select DMA_ENGINE
> >>> +	help
> >>> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
> >>> +	  exposed through a dedicated NTB memory window. The host uses the
> >>> +	  endpoint's eDMA engine to move data in both directions.
> >>> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
> >>> +
> >>>  endif # NTB
> >>> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
> >>> index 3a6fa181ff99..51f0e1e3aec7 100644
> >>> --- a/drivers/ntb/Makefile
> >>> +++ b/drivers/ntb/Makefile
> >>> @@ -4,3 +4,6 @@ obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
> >>>  
> >>>  ntb-y			:= core.o
> >>>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
> >>> +
> >>> +ntb_transport-y					:= ntb_transport_core.o
> >>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_edma.o
> >>> diff --git a/drivers/ntb/ntb_edma.c b/drivers/ntb/ntb_edma.c
> >>> new file mode 100644
> >>> index 000000000000..cb35e0d56aa8
> >>> --- /dev/null
> >>> +++ b/drivers/ntb/ntb_edma.c
> >>> @@ -0,0 +1,628 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> >>> +
> >>> +#include <linux/module.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/pci.h>
> >>> +#include <linux/ntb.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/iommu.h>
> >>> +#include <linux/dmaengine.h>
> >>> +#include <linux/pci-epc.h>
> >>> +#include <linux/dma/edma.h>
> >>> +#include <linux/irq.h>
> >>> +#include <linux/irqdomain.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/of_irq.h>
> >>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> +
> >>> +#include "ntb_edma.h"
> >>> +
> >>> +/*
> >>> + * The interrupt register offsets below are taken from the DesignWare
> >>> + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> >>> + * backend currently only supports this layout.
> >>> + */
> >>> +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> >>> +#define DMA_WRITE_INT_MASK_OFF     0x54
> >>> +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> >>> +#define DMA_READ_INT_STATUS_OFF    0xa0
> >>> +#define DMA_READ_INT_MASK_OFF      0xa8
> >>> +#define DMA_READ_INT_CLEAR_OFF     0xac
> >>> +
> >>> +#define NTB_EDMA_NOTIFY_MAX_QP		64
> >>> +
> >>> +static unsigned int edma_spi = 417; /* 0x1a1 */
> >>> +module_param(edma_spi, uint, 0644);
> >>> +MODULE_PARM_DESC(edma_spi, "SPI number used by remote eDMA interrupt (EP local)");
> >>> +
> >>> +static u64 edma_regs_phys = 0xe65d5000;
> >>> +module_param(edma_regs_phys, ullong, 0644);
> >>> +MODULE_PARM_DESC(edma_regs_phys, "Physical base address of local eDMA registers (EP)");
> >>> +
> >>> +static unsigned long edma_regs_size = 0x1200;
> >>> +module_param(edma_regs_size, ulong, 0644);
> >>> +MODULE_PARM_DESC(edma_regs_size, "Size of the local eDMA register space (EP)");
> >>> +
> >>> +struct ntb_edma_intr {
> >>> +	u32 db[NTB_EDMA_NOTIFY_MAX_QP];
> >>> +};
> >>> +
> >>> +struct ntb_edma_ctx {
> >>> +	void *ll_wr_virt[EDMA_WR_CH_NUM];
> >>> +	dma_addr_t ll_wr_phys[EDMA_WR_CH_NUM];
> >>> +	void *ll_rd_virt[EDMA_RD_CH_NUM + 1];
> >>> +	dma_addr_t ll_rd_phys[EDMA_RD_CH_NUM + 1];
> >>> +
> >>> +	struct ntb_edma_intr *intr_ep_virt;
> >>> +	dma_addr_t intr_ep_phys;
> >>> +	struct ntb_edma_intr *intr_rc_virt;
> >>> +	dma_addr_t intr_rc_phys;
> >>> +	u32 notify_qp_max;
> >>> +
> >>> +	bool initialized;
> >>> +};
> >>> +
> >>> +static struct ntb_edma_ctx edma_ctx;
> >>> +
> >>> +typedef void (*ntb_edma_interrupt_cb_t)(void *data, int qp_num);
> >>> +
> >>> +struct ntb_edma_interrupt {
> >>> +	int virq;
> >>> +	void __iomem *base;
> >>> +	ntb_edma_interrupt_cb_t cb;
> >>> +	void *data;
> >>> +};
> >>> +
> >>> +static struct ntb_edma_interrupt ntb_edma_intr;
> >>> +
> >>> +static int ntb_edma_map_spi_to_virq(struct device *dev, unsigned int spi)
> >>> +{
> >>> +	struct device_node *np = dev_of_node(dev);
> >>> +	struct device_node *parent;
> >>> +	struct irq_fwspec fwspec = { 0 };
> >>> +	int virq;
> >>> +
> >>> +	parent = of_irq_find_parent(np);
> >>> +	if (!parent)
> >>> +		return -ENODEV;
> >>> +
> >>> +	fwspec.fwnode      = of_fwnode_handle(parent);
> >>> +	fwspec.param_count = 3;
> >>> +	fwspec.param[0]    = GIC_SPI;
> >>> +	fwspec.param[1]    = spi;
> >>> +	fwspec.param[2]    = IRQ_TYPE_LEVEL_HIGH;
> >>> +
> >>> +	virq = irq_create_fwspec_mapping(&fwspec);
> >>> +	of_node_put(parent);
> >>> +	return (virq > 0) ? virq : -EINVAL;
> >>> +}
> >>> +
> >>> +static irqreturn_t ntb_edma_isr(int irq, void *data)
> >>> +{
> >>> +	struct ntb_edma_interrupt *v = data;
> >>> +	u32 mask = BIT(EDMA_RD_CH_NUM);
> >>> +	u32 i, val;
> >>> +
> >>> +	/*
> >>> +	 * We do not ack interrupts here but instead we mask all local interrupt
> >>> +	 * sources except the read channel used for notification. This reduces
> >>> +	 * needless ISR invocations.
> >>> +	 *
> >>> +	 * In theory we could configure LIE=1/RIE=0 only for the notification
> >>> +	 * transfer (keeping all other channels at LIE=1/RIE=1), but that would
> >>> +	 * require intrusive changes to the dw-edma core.
> >>> +	 *
> >>> +	 * Note: The host side may have already cleared the read interrupt used
> >>> +	 * for notification, so reading DMA_READ_INT_CLEAR_OFF is not a reliable
> >>> +	 * way to detect it. As a result, we cannot reliably tell which specific
> >>> +	 * channel triggered this interrupt. intr_ep_virt->db[i] teaches us
> >>> +	 * instead.
> >>> +	 */
> >>> +	iowrite32(~0x0, v->base + DMA_WRITE_INT_MASK_OFF);
> >>> +	iowrite32(~mask, v->base + DMA_READ_INT_MASK_OFF);
> >>> +
> >>> +	if (!v->cb || !edma_ctx.intr_ep_virt)
> >>> +		return IRQ_HANDLED;
> >>> +
> >>> +	for (i = 0; i < edma_ctx.notify_qp_max; i++) {
> >>> +		val = READ_ONCE(edma_ctx.intr_ep_virt->db[i]);
> >>> +		if (!val)
> >>> +			continue;
> >>> +
> >>> +		WRITE_ONCE(edma_ctx.intr_ep_virt->db[i], 0);
> >>> +		v->cb(v->data, i);
> >>> +	}
> >>> +
> >>> +	return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +int ntb_edma_setup_isr(struct device *dev, struct device *epc_dev,
> >>> +		       ntb_edma_interrupt_cb_t cb, void *data)
> >>> +{
> >>> +	struct ntb_edma_interrupt *v = &ntb_edma_intr;
> >>> +	int virq = ntb_edma_map_spi_to_virq(epc_dev->parent, edma_spi);
> >>> +	int ret;
> >>> +
> >>> +	if (virq < 0) {
> >>> +		dev_err(dev, "failed to get virq (%d)\n", virq);
> >>> +		return virq;
> >>> +	}
> >>> +
> >>> +	v->virq = virq;
> >>> +	v->cb = cb;
> >>> +	v->data = data;
> >>> +	if (edma_regs_phys && !v->base)
> >>> +		v->base = devm_ioremap(dev, edma_regs_phys, edma_regs_size);
> >>> +	if (!v->base) {
> >>> +		dev_err(dev, "failed to setup v->base\n");
> >>> +		return -1;
> >>> +	}
> >>> +	ret = devm_request_irq(dev, v->virq, ntb_edma_isr, 0, "ntb-edma", v);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	if (v->base) {
> >>> +		iowrite32(0x0, v->base + DMA_WRITE_INT_MASK_OFF);
> >>> +		iowrite32(0x0, v->base + DMA_READ_INT_MASK_OFF);
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +void ntb_edma_teardown_isr(struct device *dev)
> >>> +{
> >>> +	struct ntb_edma_interrupt *v = &ntb_edma_intr;
> >>> +
> >>> +	/* Mask all write/read interrupts so we don't get called again. */
> >>> +	if (v->base) {
> >>> +		iowrite32(~0x0, v->base + DMA_WRITE_INT_MASK_OFF);
> >>> +		iowrite32(~0x0, v->base + DMA_READ_INT_MASK_OFF);
> >>> +	}
> >>> +
> >>> +	if (v->virq > 0)
> >>> +		devm_free_irq(dev, v->virq, v);
> >>> +
> >>> +	if (v->base)
> >>> +		devm_iounmap(dev, v->base);
> >>> +
> >>> +	v->virq = 0;
> >>> +	v->cb = NULL;
> >>> +	v->data = NULL;
> >>> +}
> >>> +
> >>> +int ntb_edma_setup_mws(struct ntb_dev *ndev)
> >>> +{
> >>> +	const size_t info_bytes = PAGE_SIZE;
> >>> +	resource_size_t size_max, offset;
> >>> +	dma_addr_t intr_phys, info_phys;
> >>> +	u32 wr_done = 0, rd_done = 0;
> >>> +	struct ntb_edma_intr *intr;
> >>> +	struct ntb_edma_info *info;
> >>> +	int peer_mw, mw_index, rc;
> >>> +	struct iommu_domain *dom;
> >>> +	bool reg_mapped = false;
> >>> +	size_t ll_bytes, size;
> >>> +	struct pci_epc *epc;
> >>> +	struct device *dev;
> >>> +	unsigned long iova;
> >>> +	phys_addr_t phys;
> >>> +	u64 need;
> >>> +	u32 i;
> >>> +
> >>> +	/* +1 is for interruption */
> >>> +	ll_bytes = (EDMA_WR_CH_NUM + EDMA_RD_CH_NUM + 1) * DMA_LLP_MEM_SIZE;
> >>> +	need = EDMA_REG_SIZE + info_bytes + ll_bytes;
> >>> +
> >>> +	epc = ntb_get_pci_epc(ndev);
> >>> +	if (!epc)
> >>> +		return -ENODEV;
> >>> +	dev = epc->dev.parent;
> >>> +
> >>> +	if (edma_ctx.initialized)
> >>> +		return 0;
> >>> +
> >>> +	info = dma_alloc_coherent(dev, info_bytes, &info_phys, GFP_KERNEL);
> >>> +	if (!info)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	memset(info, 0, info_bytes);
> >>> +	info->magic = NTB_EDMA_INFO_MAGIC;
> >>> +	info->wr_cnt = EDMA_WR_CH_NUM;
> >>> +	info->rd_cnt = EDMA_RD_CH_NUM + 1; /* +1 for interruption */
> >>> +	info->regs_phys = edma_regs_phys;
> >>> +	info->ll_stride = DMA_LLP_MEM_SIZE;
> >>> +
> >>> +	for (i = 0; i < EDMA_WR_CH_NUM; i++) {
> >>> +		edma_ctx.ll_wr_virt[i] = dma_alloc_attrs(dev, DMA_LLP_MEM_SIZE,
> >>> +							 &edma_ctx.ll_wr_phys[i],
> >>> +							 GFP_KERNEL,
> >>> +							 DMA_ATTR_FORCE_CONTIGUOUS);
> >>> +		if (!edma_ctx.ll_wr_virt[i]) {
> >>> +			rc = -ENOMEM;
> >>> +			goto err_free_ll;
> >>> +		}
> >>> +		wr_done++;
> >>> +		info->ll_wr_phys[i] = edma_ctx.ll_wr_phys[i];
> >>> +	}
> >>> +	for (i = 0; i < EDMA_RD_CH_NUM + 1; i++) {
> >>> +		edma_ctx.ll_rd_virt[i] = dma_alloc_attrs(dev, DMA_LLP_MEM_SIZE,
> >>> +							 &edma_ctx.ll_rd_phys[i],
> >>> +							 GFP_KERNEL,
> >>> +							 DMA_ATTR_FORCE_CONTIGUOUS);
> >>> +		if (!edma_ctx.ll_rd_virt[i]) {
> >>> +			rc = -ENOMEM;
> >>> +			goto err_free_ll;
> >>> +		}
> >>> +		rd_done++;
> >>> +		info->ll_rd_phys[i] = edma_ctx.ll_rd_phys[i];
> >>> +	}
> >>> +
> >>> +	/* For interruption */
> >>> +	edma_ctx.notify_qp_max = NTB_EDMA_NOTIFY_MAX_QP;
> >>> +	intr = dma_alloc_coherent(dev, sizeof(*intr), &intr_phys, GFP_KERNEL);
> >>> +	if (!intr) {
> >>> +		rc = -ENOMEM;
> >>> +		goto err_free_ll;
> >>> +	}
> >>> +	memset(intr, 0, sizeof(*intr));
> >>> +	edma_ctx.intr_ep_virt = intr;
> >>> +	edma_ctx.intr_ep_phys = intr_phys;
> >>> +	info->intr_dar_base = intr_phys;
> >>> +
> >>> +	peer_mw = ntb_peer_mw_count(ndev);
> >>> +	if (peer_mw <= 0) {
> >>> +		rc = -ENODEV;
> >>> +		goto err_free_ll;
> >>> +	}
> >>> +
> >>> +	mw_index = peer_mw - 1; /* last MW */
> >>> +
> >>> +	rc = ntb_mw_get_align(ndev, 0, mw_index, 0, NULL, &size_max,
> >>> +			      &offset);
> >>> +	if (rc)
> >>> +		goto err_free_ll;
> >>> +
> >>> +	if (size_max < need) {
> >>> +		rc = -ENOSPC;
> >>> +		goto err_free_ll;
> >>> +	}
> >>> +
> >>> +	/* Map register space (direct) */
> >>> +	dom = iommu_get_domain_for_dev(dev);
> >>> +	if (dom) {
> >>> +		phys = edma_regs_phys & PAGE_MASK;
> >>> +		size = PAGE_ALIGN(EDMA_REG_SIZE + edma_regs_phys - phys);
> >>> +		iova = phys;
> >>> +
> >>> +		rc = iommu_map(dom, iova, phys, EDMA_REG_SIZE,
> >>> +			       IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO, GFP_KERNEL);
> >>> +		if (rc)
> >>> +			dev_err(&ndev->dev, "failed to create direct mapping for eDMA reg space\n");
> >>> +		reg_mapped = true;
> >>> +	}
> >>> +
> >>> +	rc = ntb_mw_set_trans(ndev, 0, mw_index, edma_regs_phys, EDMA_REG_SIZE, offset);
> >>> +	if (rc)
> >>> +		goto err_unmap_reg;
> >>> +
> >>> +	offset += EDMA_REG_SIZE;
> >>> +
> >>> +	/* Map ntb_edma_info */
> >>> +	rc = ntb_mw_set_trans(ndev, 0, mw_index, info_phys, info_bytes, offset);
> >>> +	if (rc)
> >>> +		goto err_clear_trans;
> >>> +	offset += info_bytes;
> >>> +
> >>> +	/* Map LL location */
> >>> +	for (i = 0; i < EDMA_WR_CH_NUM; i++) {
> >>> +		rc = ntb_mw_set_trans(ndev, 0, mw_index, edma_ctx.ll_wr_phys[i],
> >>> +				      DMA_LLP_MEM_SIZE, offset);
> >>> +		if (rc)
> >>> +			goto err_clear_trans;
> >>> +		offset += DMA_LLP_MEM_SIZE;
> >>> +	}
> >>> +	for (i = 0; i < EDMA_RD_CH_NUM + 1; i++) {
> >>> +		rc = ntb_mw_set_trans(ndev, 0, mw_index, edma_ctx.ll_rd_phys[i],
> >>> +				      DMA_LLP_MEM_SIZE, offset);
> >>> +		if (rc)
> >>> +			goto err_clear_trans;
> >>> +		offset += DMA_LLP_MEM_SIZE;
> >>> +	}
> >>> +	edma_ctx.initialized = true;
> >>> +
> >>> +	return 0;
> >>> +
> >>> +err_clear_trans:
> >>> +	/*
> >>> +	 * Tear down the NTB translation window used for the eDMA MW.
> >>> +	 * There is no sub-range clear API for ntb_mw_set_trans(), so we
> >>> +	 * unconditionally drop the whole mapping on error.
> >>> +	 */
> >>> +	ntb_mw_clear_trans(ndev, 0, mw_index);
> >>> +
> >>> +err_unmap_reg:
> >>> +	if (reg_mapped)
> >>> +		iommu_unmap(dom, iova, size);
> >>> +err_free_ll:
> >>> +	while (rd_done--)
> >>> +		dma_free_attrs(dev, DMA_LLP_MEM_SIZE,
> >>> +			       edma_ctx.ll_rd_virt[rd_done],
> >>> +			       edma_ctx.ll_rd_phys[rd_done],
> >>> +			       DMA_ATTR_FORCE_CONTIGUOUS);
> >>> +	while (wr_done--)
> >>> +		dma_free_attrs(dev, DMA_LLP_MEM_SIZE,
> >>> +			       edma_ctx.ll_wr_virt[wr_done],
> >>> +			       edma_ctx.ll_wr_phys[wr_done],
> >>> +			       DMA_ATTR_FORCE_CONTIGUOUS);
> >>> +	if (edma_ctx.intr_ep_virt)
> >>> +		dma_free_coherent(dev, sizeof(struct ntb_edma_intr),
> >>> +				  edma_ctx.intr_ep_virt,
> >>> +				  edma_ctx.intr_ep_phys);
> >>> +	dma_free_coherent(dev, info_bytes, info, info_phys);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_edma_irq_vector(struct device *dev, unsigned int nr)
> >>> +{
> >>> +	struct pci_dev *pdev = to_pci_dev(dev);
> >>> +	int ret, nvec;
> >>> +
> >>> +	nvec = pci_msi_vec_count(pdev);
> >>> +	for (; nr < nvec; nr++) {
> >>> +		ret = pci_irq_vector(pdev, nr);
> >>> +		if (!irq_has_action(ret))
> >>> +			return ret;
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static const struct dw_edma_plat_ops ntb_edma_ops = {
> >>> +	.irq_vector     = ntb_edma_irq_vector,
> >>> +};
> >>> +
> >>> +int ntb_edma_setup_peer(struct ntb_dev *ndev)
> >>> +{
> >>> +	struct ntb_edma_info *info;
> >>> +	unsigned int wr_cnt, rd_cnt;
> >>> +	struct dw_edma_chip *chip;
> >>> +	void __iomem *edma_virt;
> >>> +	phys_addr_t edma_phys;
> >>> +	resource_size_t mw_size;
> >>> +	u64 off = EDMA_REG_SIZE;
> >>> +	int peer_mw, mw_index;
> >>> +	unsigned int i;
> >>> +	int ret;
> >>> +
> >>> +	peer_mw = ntb_peer_mw_count(ndev);
> >>> +	if (peer_mw <= 0)
> >>> +		return -ENODEV;
> >>> +
> >>> +	mw_index = peer_mw - 1; /* last MW */
> >>> +
> >>> +	ret = ntb_peer_mw_get_addr(ndev, mw_index, &edma_phys,
> >>> +				   &mw_size);
> >>> +	if (ret)
> >>> +		return -1;
> >>> +
> >>> +	edma_virt = ioremap(edma_phys, mw_size);
> >>> +
> >>> +	chip = devm_kzalloc(&ndev->dev, sizeof(*chip), GFP_KERNEL);
> >>> +	if (!chip) {
> >>> +		ret = -ENOMEM;
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	chip->dev = &ndev->pdev->dev;
> >>> +	chip->nr_irqs = 4;
> >>> +	chip->ops = &ntb_edma_ops;
> >>> +	chip->flags = 0;
> >>> +	chip->reg_base = edma_virt;
> >>> +	chip->mf = EDMA_MF_EDMA_UNROLL;
> >>> +
> >>> +	info = edma_virt + off;
> >>> +	if (info->magic != NTB_EDMA_INFO_MAGIC)
> >>> +		return -EINVAL;
> >>> +	wr_cnt = info->wr_cnt;
> >>> +	rd_cnt = info->rd_cnt;
> >>> +	chip->ll_wr_cnt = wr_cnt;
> >>> +	chip->ll_rd_cnt = rd_cnt;
> >>> +	off += PAGE_SIZE;
> >>> +
> >>> +	edma_ctx.notify_qp_max = NTB_EDMA_NOTIFY_MAX_QP;
> >>> +	edma_ctx.intr_ep_phys = info->intr_dar_base;
> >>> +	if (edma_ctx.intr_ep_phys) {
> >>> +		edma_ctx.intr_rc_virt =
> >>> +			dma_alloc_coherent(&ndev->pdev->dev,
> >>> +					   sizeof(struct ntb_edma_intr),
> >>> +					   &edma_ctx.intr_rc_phys,
> >>> +					   GFP_KERNEL);
> >>> +		if (!edma_ctx.intr_rc_virt)
> >>> +			return -ENOMEM;
> >>> +		memset(edma_ctx.intr_rc_virt, 0,
> >>> +		       sizeof(struct ntb_edma_intr));
> >>> +	}
> >>> +
> >>> +	for (i = 0; i < wr_cnt; i++) {
> >>> +		chip->ll_region_wr[i].vaddr.io = edma_virt + off;
> >>> +		chip->ll_region_wr[i].paddr = info->ll_wr_phys[i];
> >>> +		chip->ll_region_wr[i].sz = DMA_LLP_MEM_SIZE;
> >>> +		off += DMA_LLP_MEM_SIZE;
> >>> +	}
> >>> +	for (i = 0; i < rd_cnt; i++) {
> >>> +		chip->ll_region_rd[i].vaddr.io = edma_virt + off;
> >>> +		chip->ll_region_rd[i].paddr = info->ll_rd_phys[i];
> >>> +		chip->ll_region_rd[i].sz = DMA_LLP_MEM_SIZE;
> >>> +		off += DMA_LLP_MEM_SIZE;
> >>> +	}
> >>> +
> >>> +	if (!pci_dev_msi_enabled(ndev->pdev))
> >>> +		return -ENXIO;
> >>> +
> >>> +	ret = dw_edma_probe(chip);
> >>> +	if (ret) {
> >>> +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +struct ntb_edma_filter {
> >>> +	struct device *dma_dev;
> >>> +	u32 direction;
> >>> +};
> >>> +
> >>> +static bool ntb_edma_filter_fn(struct dma_chan *chan, void *arg)
> >>> +{
> >>> +	struct ntb_edma_filter *filter = arg;
> >>> +	u32 dir = filter->direction;
> >>> +	struct dma_slave_caps caps;
> >>> +	int ret;
> >>> +
> >>> +	if (chan->device->dev != filter->dma_dev)
> >>> +		return false;
> >>> +
> >>> +	ret = dma_get_slave_caps(chan, &caps);
> >>> +	if (ret < 0)
> >>> +		return false;
> >>> +
> >>> +	return !!(caps.directions & dir);
> >>> +}
> >>> +
> >>> +void ntb_edma_teardown_chans(struct ntb_edma_chans *edma)
> >>> +{
> >>> +	unsigned int i;
> >>> +
> >>> +	for (i = 0; i < edma->num_wr_chan; i++)
> >>> +		dma_release_channel(edma->wr_chan[i]);
> >>> +
> >>> +	for (i = 0; i < edma->num_rd_chan; i++)
> >>> +		dma_release_channel(edma->rd_chan[i]);
> >>> +
> >>> +	if (edma->intr_chan)
> >>> +		dma_release_channel(edma->intr_chan);
> >>> +}
> >>> +
> >>> +int ntb_edma_setup_chans(struct device *dma_dev, struct ntb_edma_chans *edma)
> >>> +{
> >>> +	struct ntb_edma_filter filter;
> >>> +	dma_cap_mask_t dma_mask;
> >>> +	unsigned int i;
> >>> +
> >>> +	dma_cap_zero(dma_mask);
> >>> +	dma_cap_set(DMA_SLAVE, dma_mask);
> >>> +
> >>> +	memset(edma, 0, sizeof(*edma));
> >>> +	edma->dev = dma_dev;
> >>> +
> >>> +	filter.dma_dev = dma_dev;
> >>> +	filter.direction = BIT(DMA_DEV_TO_MEM);
> >>> +	for (i = 0; i < EDMA_WR_CH_NUM; i++) {
> >>> +		edma->wr_chan[i] = dma_request_channel(dma_mask,
> >>> +						       ntb_edma_filter_fn,
> >>> +						       &filter);
> >>> +		if (!edma->wr_chan[i])
> >>> +			break;
> >>> +		edma->num_wr_chan++;
> >>> +	}
> >>> +
> >>> +	filter.direction = BIT(DMA_MEM_TO_DEV);
> >>> +	for (i = 0; i < EDMA_RD_CH_NUM; i++) {
> >>> +		edma->rd_chan[i] = dma_request_channel(dma_mask,
> >>> +						       ntb_edma_filter_fn,
> >>> +						       &filter);
> >>> +		if (!edma->rd_chan[i])
> >>> +			break;
> >>> +		edma->num_rd_chan++;
> >>> +	}
> >>> +
> >>> +	edma->intr_chan = dma_request_channel(dma_mask, ntb_edma_filter_fn,
> >>> +					      &filter);
> >>> +	if (!edma->intr_chan)
> >>> +		dev_warn(dma_dev,
> >>> +			 "Remote eDMA notify channel could not be allocated\n");
> >>> +
> >>> +	if (!edma->num_wr_chan || !edma->num_rd_chan) {
> >>> +		dev_warn(dma_dev, "Remote eDMA channels failed to initialize\n");
> >>> +		ntb_edma_teardown_chans(edma);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +struct dma_chan *ntb_edma_pick_chan(struct ntb_edma_chans *edma,
> >>> +				    remote_edma_dir_t dir)
> >>> +{
> >>> +	unsigned int n, cur, idx;
> >>> +	struct dma_chan **chans;
> >>> +	atomic_t *cur_chan;
> >>> +
> >>> +	if (dir == REMOTE_EDMA_WRITE) {
> >>> +		n = edma->num_wr_chan;
> >>> +		chans = edma->wr_chan;
> >>> +		cur_chan = &edma->cur_wr_chan;
> >>> +	} else {
> >>> +		n = edma->num_rd_chan;
> >>> +		chans = edma->rd_chan;
> >>> +		cur_chan = &edma->cur_rd_chan;
> >>> +	}
> >>> +	if (WARN_ON_ONCE(!n))
> >>> +		return NULL;
> >>> +
> >>> +	/* Simple round-robin */
> >>> +	cur = (unsigned int)atomic_inc_return(cur_chan) - 1;
> >>> +	idx = cur % n;
> >>> +	return chans[idx];
> >>> +}
> >>> +
> >>> +int ntb_edma_notify_peer(struct ntb_edma_chans *edma, int qp_num)
> >>> +{
> >>> +	struct dma_async_tx_descriptor *txd;
> >>> +	struct dma_slave_config cfg;
> >>> +	struct scatterlist sgl;
> >>> +	dma_cookie_t cookie;
> >>> +	struct device *dev;
> >>> +
> >>> +	if (!edma || !edma->intr_chan)
> >>> +		return -ENXIO;
> >>> +
> >>> +	if (qp_num < 0 || qp_num >= edma_ctx.notify_qp_max)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (!edma_ctx.intr_rc_virt || !edma_ctx.intr_ep_phys)
> >>> +		return -EINVAL;
> >>> +
> >>> +	dev = edma->dev;
> >>> +	if (!dev)
> >>> +		return -ENODEV;
> >>> +
> >>> +	WRITE_ONCE(edma_ctx.intr_rc_virt->db[qp_num], 1);
> >>> +
> >>> +	/* Ensure store is visible before kicking the DMA transfer */
> >>> +	wmb();
> >>> +
> >>> +	sg_init_table(&sgl, 1);
> >>> +	sg_dma_address(&sgl) = edma_ctx.intr_rc_phys + qp_num * sizeof(u32);
> >>> +	sg_dma_len(&sgl) = sizeof(u32);
> >>> +
> >>> +	memset(&cfg, 0, sizeof(cfg));
> >>> +	cfg.dst_addr       = edma_ctx.intr_ep_phys + qp_num * sizeof(u32);
> >>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.direction      = DMA_MEM_TO_DEV;
> >>> +
> >>> +	if (dmaengine_slave_config(edma->intr_chan, &cfg))
> >>> +		return -EINVAL;
> >>> +
> >>> +	txd = dmaengine_prep_slave_sg(edma->intr_chan, &sgl, 1,
> >>> +				      DMA_MEM_TO_DEV,
> >>> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> >>> +	if (!txd)
> >>> +		return -ENOSPC;
> >>> +
> >>> +	cookie = dmaengine_submit(txd);
> >>> +	if (dma_submit_error(cookie))
> >>> +		return -ENOSPC;
> >>> +
> >>> +	dma_async_issue_pending(edma->intr_chan);
> >>> +	return 0;
> >>> +}
> >>> diff --git a/drivers/ntb/ntb_edma.h b/drivers/ntb/ntb_edma.h
> >>> new file mode 100644
> >>> index 000000000000..da0451827edb
> >>> --- /dev/null
> >>> +++ b/drivers/ntb/ntb_edma.h
> >>> @@ -0,0 +1,128 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> >>> +#ifndef _NTB_EDMA_H_
> >>> +#define _NTB_EDMA_H_
> >>> +
> >>> +#include <linux/completion.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/interrupt.h>
> >>> +
> >>> +#define EDMA_REG_SIZE		SZ_64K
> >>> +#define DMA_LLP_MEM_SIZE	SZ_4K
> >>> +#define EDMA_WR_CH_NUM		4
> >>> +#define EDMA_RD_CH_NUM		4
> >>> +#define NTB_EDMA_MAX_CH		8
> >>> +
> >>> +#define NTB_EDMA_INFO_MAGIC	0x45444D41 /* "EDMA" */
> >>> +#define NTB_EDMA_INFO_OFF	EDMA_REG_SIZE
> >>> +
> >>> +#define NTB_EDMA_RING_ORDER	7
> >>> +#define NTB_EDMA_RING_ENTRIES	(1U << NTB_EDMA_RING_ORDER)
> >>> +#define NTB_EDMA_RING_MASK	(NTB_EDMA_RING_ENTRIES - 1)
> >>> +
> >>> +typedef void (*ntb_edma_interrupt_cb_t)(void *data, int qp_num);
> >>> +
> >>> +/*
> >>> + * REMOTE_EDMA_EP:
> >>> + *   Endpoint owns the eDMA engine and pushes descriptors into a shared MW.
> >>> + *
> >>> + * REMOTE_EDMA_RC:
> >>> + *   Root Complex controls the endpoint eDMA through the shared MW and
> >>> + *   drives reads/writes on behalf of the host.
> >>> + */
> >>> +typedef enum {
> >>> +	REMOTE_EDMA_UNKNOWN,
> >>> +	REMOTE_EDMA_EP,
> >>> +	REMOTE_EDMA_RC,
> >>> +} remote_edma_mode_t;
> >>> +
> >>> +typedef enum {
> >>> +	REMOTE_EDMA_WRITE,
> >>> +	REMOTE_EDMA_READ,
> >>> +} remote_edma_dir_t;
> >>> +
> >>> +/*
> >>> + * Layout of remote eDMA MW (EP local address space, RC sees via peer MW):
> >>> + *
> >>> + *  0 .. EDMA_REG_SIZE-1        : DesignWare eDMA registers
> >>> + *  EDMA_REG_SIZE .. +PAGE_SIZE : struct ntb_edma_info (EP writes, RC reads)
> >>> + *  +PAGE_SIZE ..               : LL ring buffers (EP allocates phys addresses,
> >>> + *                                RC configures via dw_edma)
> >>> + *
> >>> + * ntb_edma_setup_mws() on EP:
> >>> + *   - allocates ntb_edma_info and LLs in EP memory
> >>> + *   - programs inbound iATU so that RC peer MW[n] points at this block
> >>> + *
> >>> + * ntb_edma_setup_peer() on RC:
> >>> + *   - ioremaps peer MW[n]
> >>> + *   - reads ntb_edma_info
> >>> + *   - sets up dw_edma_chip ll_region_* from that info
> >>> + */
> >>> +struct ntb_edma_info {
> >>> +	u32 magic;
> >>> +	u16 wr_cnt;
> >>> +	u16 rd_cnt;
> >>> +	u64 regs_phys;
> >>> +	u32 ll_stride;
> >>> +	u32 rsvd;
> >>> +	u64 ll_wr_phys[NTB_EDMA_MAX_CH];
> >>> +	u64 ll_rd_phys[NTB_EDMA_MAX_CH];
> >>> +
> >>> +	u64 intr_dar_base;
> >>> +} __packed;
> >>> +
> >>> +struct ll_dma_addrs {
> >>> +	dma_addr_t wr[EDMA_WR_CH_NUM];
> >>> +	dma_addr_t rd[EDMA_RD_CH_NUM];
> >>> +};
> >>> +
> >>> +struct ntb_edma_chans {
> >>> +	struct device *dev;
> >>> +
> >>> +	struct dma_chan *wr_chan[EDMA_WR_CH_NUM];
> >>> +	struct dma_chan *rd_chan[EDMA_RD_CH_NUM];
> >>> +	struct dma_chan *intr_chan;
> >>> +
> >>> +	unsigned int num_wr_chan;
> >>> +	unsigned int num_rd_chan;
> >>> +	atomic_t cur_wr_chan;
> >>> +	atomic_t cur_rd_chan;
> >>> +};
> >>> +
> >>> +static __always_inline u32 ntb_edma_ring_idx(u32 v)
> >>> +{
> >>> +	return v & NTB_EDMA_RING_MASK;
> >>> +}
> >>> +
> >>> +static __always_inline u32 ntb_edma_ring_used_entry(u32 head, u32 tail)
> >>> +{
> >>> +	if (head >= tail) {
> >>> +		WARN_ON_ONCE((head - tail) > (NTB_EDMA_RING_ENTRIES - 1));
> >>> +		return head - tail;
> >>> +	}
> >>> +
> >>> +	WARN_ON_ONCE((U32_MAX - tail + head + 1) > (NTB_EDMA_RING_ENTRIES - 1));
> >>> +	return U32_MAX - tail + head + 1;
> >>> +}
> >>> +
> >>> +static __always_inline u32 ntb_edma_ring_free_entry(u32 head, u32 tail)
> >>> +{
> >>> +	return NTB_EDMA_RING_ENTRIES - ntb_edma_ring_used_entry(head, tail) - 1;
> >>> +}
> >>> +
> >>> +static __always_inline bool ntb_edma_ring_full(u32 head, u32 tail)
> >>> +{
> >>> +	return ntb_edma_ring_free_entry(head, tail) == 0;
> >>> +}
> >>> +
> >>> +int ntb_edma_setup_isr(struct device *dev, struct device *epc_dev,
> >>> +		       ntb_edma_interrupt_cb_t cb, void *data);
> >>> +void ntb_edma_teardown_isr(struct device *dev);
> >>> +int ntb_edma_setup_mws(struct ntb_dev *ndev);
> >>> +int ntb_edma_setup_peer(struct ntb_dev *ndev);
> >>> +int ntb_edma_setup_chans(struct device *dma_dev, struct ntb_edma_chans *edma);
> >>> +struct dma_chan *ntb_edma_pick_chan(struct ntb_edma_chans *edma,
> >>> +				    remote_edma_dir_t dir);
> >>> +void ntb_edma_teardown_chans(struct ntb_edma_chans *edma);
> >>> +int ntb_edma_notify_peer(struct ntb_edma_chans *edma, int qp_num);
> >>> +
> >>> +#endif
> >>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport_core.c
> >>> similarity index 65%
> >>> rename from drivers/ntb/ntb_transport.c
> >>> rename to drivers/ntb/ntb_transport_core.c
> >>> index 907db6c93d4d..48d48921978d 100644
> >>> --- a/drivers/ntb/ntb_transport.c
> >>> +++ b/drivers/ntb/ntb_transport_core.c
> >>> @@ -47,6 +47,9 @@
> >>>   * Contact Information:
> >>>   * Jon Mason <jon.mason@intel.com>
> >>>   */
> >>> +#include <linux/atomic.h>
> >>> +#include <linux/bug.h>
> >>> +#include <linux/compiler.h>
> >>>  #include <linux/debugfs.h>
> >>>  #include <linux/delay.h>
> >>>  #include <linux/dmaengine.h>
> >>> @@ -71,6 +74,8 @@
> >>>  #define NTB_TRANSPORT_DESC	"Software Queue-Pair Transport over NTB"
> >>>  #define NTB_TRANSPORT_MIN_SPADS (MW0_SZ_HIGH + 2)
> >>>  
> >>> +#define NTB_EDMA_MAX_POLL		32
> >>> +
> >>>  MODULE_DESCRIPTION(NTB_TRANSPORT_DESC);
> >>>  MODULE_VERSION(NTB_TRANSPORT_VER);
> >>>  MODULE_LICENSE("Dual BSD/GPL");
> >>> @@ -102,6 +107,13 @@ module_param(use_msi, bool, 0644);
> >>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
> >>>  #endif
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>
> >> This is a comment throughout this patch. Doing ifdefs inside C source is pretty frowed upon in the kernel. The preferred way is to only have ifdefs in the header files. So please give this a bit more consideration and see if it can be done differently to address this.
> > 
> > I agree, there is no good reason to keep those remaining ifdefs at all.
> > I'll clean it up. Thanks for pointing this out.
> > 
> >>
> >>> +#include "ntb_edma.h"
> >>> +static bool use_remote_edma;
> >>> +module_param(use_remote_edma, bool, 0644);
> >>> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
> >>> +#endif
> >>> +
> >>>  static struct dentry *nt_debugfs_dir;
> >>>  
> >>>  /* Only two-ports NTB devices are supported */
> >>> @@ -125,6 +137,14 @@ struct ntb_queue_entry {
> >>>  		struct ntb_payload_header __iomem *tx_hdr;
> >>>  		struct ntb_payload_header *rx_hdr;
> >>>  	};
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	dma_addr_t addr;
> >>> +
> >>> +	/* Used by RC side only */
> >>> +	struct scatterlist sgl;
> >>> +	struct work_struct dma_work;
> >>> +#endif
> >>>  };
> >>>  
> >>>  struct ntb_rx_info {
> >>> @@ -202,6 +222,33 @@ struct ntb_transport_qp {
> >>>  	int msi_irq;
> >>>  	struct ntb_msi_desc msi_desc;
> >>>  	struct ntb_msi_desc peer_msi_desc;
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	/*
> >>> +	 * For ensuring peer notification in non-atomic context.
> >>> +	 * ntb_peer_db_set might sleep or schedule.
> >>> +	 */
> >>> +	struct work_struct db_work;
> >>> +
> >>> +	/*
> >>> +	 * wr: remote eDMA write transfer (EP -> RC direction)
> >>> +	 * rd: remote eDMA read transfer (RC -> EP direction)
> >>> +	 */
> >>> +	u32 wr_cons;
> >>> +	u32 rd_cons;
> >>> +	u32 wr_prod;
> >>> +	u32 rd_prod;
> >>> +	u32 wr_issue;
> >>> +	u32 rd_issue;
> >>> +
> >>> +	spinlock_t ep_tx_lock;
> >>> +	spinlock_t ep_rx_lock;
> >>> +	spinlock_t rc_lock;
> >>> +
> >>> +	/* Completion work for read/write transfers. */
> >>> +	struct work_struct read_work;
> >>> +	struct work_struct write_work;
> >>> +#endif
> >>
> >> For something like this, maybe it needs its own struct instead of an ifdef chunk. Perhaps 'ntb_rx_info' can serve as a core data struct with EDMA having 'ntb_rx_info_edma' and embed 'ntb_rx_info'. 
> > 
> > Thanks again for the suggestion. I'll reorganize things.
> > 
> > Koichiro
> > 
> >>
> >> DJ
> >>
> >>>  };
> >>>  
> >>>  struct ntb_transport_mw {
> >>> @@ -249,6 +296,13 @@ struct ntb_transport_ctx {
> >>>  
> >>>  	/* Make sure workq of link event be executed serially */
> >>>  	struct mutex link_event_lock;
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	remote_edma_mode_t remote_edma_mode;
> >>> +	struct device *dma_dev;
> >>> +	struct workqueue_struct *wq;
> >>> +	struct ntb_edma_chans edma;
> >>> +#endif
> >>>  };
> >>>  
> >>>  enum {
> >>> @@ -262,6 +316,19 @@ struct ntb_payload_header {
> >>>  	unsigned int flags;
> >>>  };
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +static void ntb_transport_edma_uninit(struct ntb_transport_ctx *nt);
> >>> +static int ntb_transport_edma_init(struct ntb_transport_ctx *nt,
> >>> +				   unsigned int *mw_count);
> >>> +static void ntb_transport_edma_init_queue(struct ntb_transport_ctx *nt,
> >>> +					  unsigned int qp_num);
> >>> +static void ntb_transport_edma_create_queue(struct ntb_transport_ctx *nt,
> >>> +					    struct ntb_transport_qp *qp);
> >>> +static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt);
> >>> +static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt);
> >>> +static void ntb_transport_edma_rc_dma_work(struct work_struct *work);
> >>> +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> >>> +
> >>>  /*
> >>>   * Return the device that should be used for DMA mapping.
> >>>   *
> >>> @@ -298,7 +365,7 @@ enum {
> >>>  	container_of((__drv), struct ntb_transport_client, driver)
> >>>  
> >>>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
> >>> -#define NTB_QP_DEF_NUM_ENTRIES	100
> >>> +#define NTB_QP_DEF_NUM_ENTRIES	128
> >>>  #define NTB_LINK_DOWN_TIMEOUT	10
> >>>  
> >>>  static void ntb_transport_rxc_db(unsigned long data);
> >>> @@ -1015,6 +1082,10 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >>>  	count = ntb_spad_count(nt->ndev);
> >>>  	for (i = 0; i < count; i++)
> >>>  		ntb_spad_write(nt->ndev, i, 0);
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	ntb_edma_teardown_chans(&nt->edma);
> >>> +#endif
> >>>  }
> >>>  
> >>>  static void ntb_transport_link_cleanup_work(struct work_struct *work)
> >>> @@ -1051,6 +1122,14 @@ static void ntb_transport_link_work(struct work_struct *work)
> >>>  
> >>>  	/* send the local info, in the opposite order of the way we read it */
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	rc = ntb_transport_edma_ep_init(nt);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to init EP: %d\n", rc);
> >>> +		return;
> >>> +	}
> >>> +#endif
> >>> +
> >>>  	if (nt->use_msi) {
> >>>  		rc = ntb_msi_setup_mws(ndev);
> >>>  		if (rc) {
> >>> @@ -1132,6 +1211,14 @@ static void ntb_transport_link_work(struct work_struct *work)
> >>>  
> >>>  	nt->link_is_up = true;
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	rc = ntb_transport_edma_rc_init(nt);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to init RC: %d\n", rc);
> >>> +		goto out1;
> >>> +	}
> >>> +#endif
> >>> +
> >>>  	for (i = 0; i < nt->qp_count; i++) {
> >>>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >>>  
> >>> @@ -1277,6 +1364,8 @@ static const struct ntb_transport_backend_ops default_backend_ops = {
> >>>  	.debugfs_stats_show = ntb_transport_default_debugfs_stats_show,
> >>>  };
> >>>  
> >>> +static const struct ntb_transport_backend_ops edma_backend_ops;
> >>> +
> >>>  static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >>>  {
> >>>  	struct ntb_transport_ctx *nt;
> >>> @@ -1311,7 +1400,23 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >>>  
> >>>  	nt->ndev = ndev;
> >>>  
> >>> -	nt->backend_ops = default_backend_ops;
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	if (use_remote_edma) {
> >>> +		rc = ntb_transport_edma_init(nt, &mw_count);
> >>> +		if (rc) {
> >>> +			nt->mw_count = 0;
> >>> +			goto err;
> >>> +		}
> >>> +		nt->backend_ops = edma_backend_ops;
> >>> +
> >>> +		/*
> >>> +		 * On remote eDMA mode, we reserve a read channel for Host->EP
> >>> +		 * interruption.
> >>> +		 */
> >>> +		use_msi = false;
> >>> +	} else
> >>> +#endif
> >>> +		nt->backend_ops = default_backend_ops;
> >>>  
> >>>  	/*
> >>>  	 * If we are using MSI, and have at least one extra memory window,
> >>> @@ -1402,6 +1507,10 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >>>  		rc = ntb_transport_init_queue(nt, i);
> >>>  		if (rc)
> >>>  			goto err2;
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +		ntb_transport_edma_init_queue(nt, i);
> >>> +#endif
> >>>  	}
> >>>  
> >>>  	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
> >>> @@ -1433,6 +1542,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >>>  	}
> >>>  	kfree(nt->mw_vec);
> >>>  err:
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	ntb_transport_edma_uninit(nt);
> >>> +#endif
> >>>  	kfree(nt);
> >>>  	return rc;
> >>>  }
> >>> @@ -2055,11 +2167,16 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>  
> >>>  	nt->qp_bitmap_free &= ~qp_bit;
> >>>  
> >>> +	qp->qp_bit = qp_bit;
> >>>  	qp->cb_data = data;
> >>>  	qp->rx_handler = handlers->rx_handler;
> >>>  	qp->tx_handler = handlers->tx_handler;
> >>>  	qp->event_handler = handlers->event_handler;
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	ntb_transport_edma_create_queue(nt, qp);
> >>> +#endif
> >>> +
> >>>  	dma_cap_zero(dma_mask);
> >>>  	dma_cap_set(DMA_MEMCPY, dma_mask);
> >>>  
> >>> @@ -2105,6 +2222,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>  			goto err1;
> >>>  
> >>>  		entry->qp = qp;
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +		INIT_WORK(&entry->dma_work, ntb_transport_edma_rc_dma_work);
> >>> +#endif
> >>>  		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> >>>  			     &qp->rx_free_q);
> >>>  	}
> >>> @@ -2156,8 +2276,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
> >>>   */
> >>>  void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  {
> >>> -	struct pci_dev *pdev;
> >>>  	struct ntb_queue_entry *entry;
> >>> +	struct pci_dev *pdev;
> >>>  	u64 qp_bit;
> >>>  
> >>>  	if (!qp)
> >>> @@ -2208,6 +2328,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  	tasklet_kill(&qp->rxc_db_work);
> >>>  
> >>>  	cancel_delayed_work_sync(&qp->link_work);
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	cancel_work_sync(&qp->read_work);
> >>> +	cancel_work_sync(&qp->write_work);
> >>> +#endif
> >>>  
> >>>  	qp->cb_data = NULL;
> >>>  	qp->rx_handler = NULL;
> >>> @@ -2346,6 +2470,1157 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(ntb_transport_tx_enqueue);
> >>>  
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +/*
> >>> + * Remote eDMA mode implementation
> >>> + */
> >>> +struct ntb_edma_desc {
> >>> +	u32 len;
> >>> +	u32 flags;
> >>> +	u64 addr; /* DMA address */
> >>> +	u64 data;
> >>> +};
> >>> +
> >>> +struct ntb_edma_ring {
> >>> +	struct ntb_edma_desc desc[NTB_EDMA_RING_ENTRIES];
> >>> +	u32 head;
> >>> +	u32 tail;
> >>> +};
> >>> +
> >>> +#define NTB_EDMA_DESC_OFF(i)	((size_t)(i) * sizeof(struct ntb_edma_desc))
> >>> +
> >>> +#define __NTB_EDMA_CHECK_INDEX(_i)					\
> >>> +({									\
> >>> +	unsigned long __i = (unsigned long)(_i);			\
> >>> +	WARN_ONCE(__i >= (unsigned long)NTB_EDMA_RING_ENTRIES,		\
> >>> +		  "ntb_edma: index i=%lu >= ring_entries=%lu\n",	\
> >>> +		  __i, (unsigned long)NTB_EDMA_RING_ENTRIES);		\
> >>> +	__i;								\
> >>> +})
> >>> +
> >>> +#define NTB_EDMA_DESC_I(qp, i, n)					\
> >>> +({									\
> >>> +	typeof(qp) __qp = (qp);						\
> >>> +	unsigned long __i = __NTB_EDMA_CHECK_INDEX(i);			\
> >>> +	(struct ntb_edma_desc *)					\
> >>> +		((char *)(__qp)->rx_buff +				\
> >>> +		 (sizeof(struct ntb_edma_ring) * n) +			\
> >>> +		 NTB_EDMA_DESC_OFF(__i));				\
> >>> +})
> >>> +
> >>> +#define NTB_EDMA_DESC_O(qp, i, n)					\
> >>> +({									\
> >>> +	typeof(qp) __qp = (qp);						\
> >>> +	unsigned long __i = __NTB_EDMA_CHECK_INDEX(i);			\
> >>> +	(struct ntb_edma_desc __iomem *)				\
> >>> +		((char __iomem *)(__qp)->tx_mw +			\
> >>> +		 (sizeof(struct ntb_edma_ring) * n) +			\
> >>> +		 NTB_EDMA_DESC_OFF(__i));				\
> >>> +})
> >>> +
> >>> +#define NTB_EDMA_HEAD_I(qp, n) ((u32 *)((char *)qp->rx_buff +		\
> >>> +				(sizeof(struct ntb_edma_ring) * n) +	\
> >>> +				offsetof(struct ntb_edma_ring, head)))
> >>> +#define NTB_EDMA_HEAD_O(qp, n) ((u32 *)((char __iomem *)qp->tx_mw +	\
> >>> +				(sizeof(struct ntb_edma_ring) * n) +	\
> >>> +				offsetof(struct ntb_edma_ring, head)))
> >>> +#define NTB_EDMA_TAIL_I(qp, n) ((u32 *)((char *)qp->rx_buff +		\
> >>> +				(sizeof(struct ntb_edma_ring) * n) +	\
> >>> +				offsetof(struct ntb_edma_ring, tail)))
> >>> +#define NTB_EDMA_TAIL_O(qp, n) ((u32 *)((char __iomem *)qp->tx_mw +	\
> >>> +				(sizeof(struct ntb_edma_ring) * n) +	\
> >>> +				offsetof(struct ntb_edma_ring, tail)))
> >>> +
> >>> +/*
> >>> + * Macro naming rule:
> >>> + *   NTB_DESC_RD_EP_I (as an example)
> >>> + *            ^^ ^^ ^
> >>> + *            :  :  `-- I(n) or O(ut). In = Read, Out = Write.
> >>> + *            :  `----- Who uses this macro.
> >>> + *            `-------- DESC / HEAD / TAIL
> >>> + *
> >>> + * Read transfers (RC->EP):
> >>> + *
> >>> + *   EP view (outbound, written via NTB):
> >>> + *       - descs: NTB_DESC_RD_EP_O(qp, i) / NTB_DESC_RD_EP_I(qp, i)
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *           :
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *       - head: NTB_HEAD_RD_EP_O(qp)
> >>> + *       - tail: NTB_TAIL_RD_EP_I(qp)
> >>> + *
> >>> + *   RC view (inbound, local mapping):
> >>> + *       - descs: NTB_DESC_RD_RC_I(qp, i) / NTB_DESC_RD_RC_O(qp, i)
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *           :
> >>> + *           [ len ][ flags ][ addr ][ data ]
> >>> + *       - head: NTB_HEAD_RD_RC_I(qp)
> >>> + *       - tail: NTB_TAIL_RD_RC_O(qp)
> >>> + *
> >>> + * Write transfers (EP -> RC) are analogous but use
> >>> + * NTB_DESC_WR_{EP_O,RC_I}(), NTB_HEAD_WR_{EP_O,RC_I}(),
> >>> + * and NTB_TAIL_WR_{EP_I,RC_O}().
> >>> + */
> >>> +#define NTB_DESC_RD_EP_I(qp, i)	NTB_EDMA_DESC_I(qp, i, 0)
> >>> +#define NTB_DESC_RD_EP_O(qp, i)	NTB_EDMA_DESC_O(qp, i, 0)
> >>> +#define NTB_DESC_WR_EP_I(qp, i)	NTB_EDMA_DESC_I(qp, i, 1)
> >>> +#define NTB_DESC_WR_EP_O(qp, i)	NTB_EDMA_DESC_O(qp, i, 1)
> >>> +#define NTB_DESC_RD_RC_I(qp, i)	NTB_EDMA_DESC_I(qp, i, 0)
> >>> +#define NTB_DESC_RD_RC_O(qp, i)	NTB_EDMA_DESC_O(qp, i, 0)
> >>> +#define NTB_DESC_WR_RC_I(qp, i)	NTB_EDMA_DESC_I(qp, i, 1)
> >>> +#define NTB_DESC_WR_RC_O(qp, i)	NTB_EDMA_DESC_O(qp, i, 1)
> >>> +
> >>> +#define NTB_HEAD_RD_EP_O(qp)	NTB_EDMA_HEAD_O(qp, 0)
> >>> +#define NTB_HEAD_WR_EP_O(qp)	NTB_EDMA_HEAD_O(qp, 1)
> >>> +#define NTB_HEAD_RD_RC_I(qp)	NTB_EDMA_HEAD_I(qp, 0)
> >>> +#define NTB_HEAD_WR_RC_I(qp)	NTB_EDMA_HEAD_I(qp, 1)
> >>> +
> >>> +#define NTB_TAIL_RD_EP_I(qp)	NTB_EDMA_TAIL_I(qp, 0)
> >>> +#define NTB_TAIL_WR_EP_I(qp)	NTB_EDMA_TAIL_I(qp, 1)
> >>> +#define NTB_TAIL_RD_RC_O(qp)	NTB_EDMA_TAIL_O(qp, 0)
> >>> +#define NTB_TAIL_WR_RC_O(qp)	NTB_EDMA_TAIL_O(qp, 1)
> >>> +
> >>> +static inline bool ntb_qp_edma_is_rc(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return qp->transport->remote_edma_mode == REMOTE_EDMA_RC;
> >>> +}
> >>> +
> >>> +static inline bool ntb_qp_edma_is_ep(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return qp->transport->remote_edma_mode == REMOTE_EDMA_EP;
> >>> +}
> >>> +
> >>> +static inline bool ntb_qp_edma_enabled(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return ntb_qp_edma_is_rc(qp) || ntb_qp_edma_is_ep(qp);
> >>> +}
> >>> +
> >>> +static unsigned int ntb_transport_edma_tx_free_entry(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	unsigned int head, tail;
> >>> +
> >>> +	if (ntb_qp_edma_is_ep(qp)) {
> >>> +		scoped_guard(spinlock_irqsave, &qp->ep_tx_lock) {
> >>> +			/* In this scope, only 'head' might proceed */
> >>> +			tail = READ_ONCE(qp->wr_cons);
> >>> +			head = READ_ONCE(qp->wr_prod);
> >>> +		}
> >>> +		return ntb_edma_ring_free_entry(head, tail);
> >>> +	}
> >>> +
> >>> +	scoped_guard(spinlock_irqsave, &qp->rc_lock) {
> >>> +		/* In this scope, only 'head' might proceed */
> >>> +		tail = READ_ONCE(qp->rd_issue);
> >>> +		head = READ_ONCE(*NTB_HEAD_RD_RC_I(qp));
> >>> +	}
> >>> +	/*
> >>> +	 * On RC side, 'used' amount indicates how much EP side
> >>> +	 * has refilled, which are available for us to use for TX.
> >>> +	 */
> >>> +	return ntb_edma_ring_used_entry(head, tail);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_debugfs_stats_show(struct seq_file *s,
> >>> +						  struct ntb_transport_qp *qp)
> >>> +{
> >>> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> >>> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> >>> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> >>> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> >>> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> >>> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> >>> +
> >>> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> >>> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> >>> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> >>> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> >>> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> >>> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> >>> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> >>> +	seq_putc(s, '\n');
> >>> +
> >>> +	seq_puts(s, "Using Remote eDMA - Yes\n");
> >>> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_uninit(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +
> >>> +	if (nt->remote_edma_mode == REMOTE_EDMA_EP && ndev && ndev->pdev)
> >>> +		ntb_edma_teardown_isr(&ndev->pdev->dev);
> >>> +
> >>> +	if (nt->wq)
> >>> +		destroy_workqueue(nt->wq);
> >>> +	nt->wq = NULL;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_init(struct ntb_transport_ctx *nt,
> >>> +				   unsigned int *mw_count)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +
> >>> +	/*
> >>> +	 * We need at least one MW for the transport plus one MW reserved
> >>> +	 * for the remote eDMA window (see ntb_edma_setup_mws/peer).
> >>> +	 */
> >>> +	if (*mw_count <= 1) {
> >>> +		dev_err(&ndev->dev,
> >>> +			"remote eDMA requires at least two MWS (have %u)\n",
> >>> +			*mw_count);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	nt->wq = alloc_workqueue("ntb-edma-wq", WQ_UNBOUND | WQ_SYSFS, 0);
> >>> +	if (!nt->wq) {
> >>> +		ntb_transport_edma_uninit(nt);
> >>> +		return -ENOMEM;
> >>> +	}
> >>> +
> >>> +	/* Reserve the last peer MW exclusively for the eDMA window. */
> >>> +	*mw_count -= 1;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_db_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp =
> >>> +			container_of(work, struct ntb_transport_qp, db_work);
> >>> +
> >>> +	ntb_peer_db_set(qp->ndev, qp->qp_bit);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_notify_peer(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	if (ntb_qp_edma_is_rc(qp))
> >>> +		if (!ntb_edma_notify_peer(&qp->transport->edma, qp->qp_num))
> >>> +			return;
> >>> +
> >>> +	/*
> >>> +	 * Called from contexts that may be atomic. Since ntb_peer_db_set()
> >>> +	 * may sleep, delegate the actual doorbell write to a workqueue.
> >>> +	 */
> >>> +	queue_work(system_highpri_wq, &qp->db_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_isr(void *data, int qp_num)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = data;
> >>> +	struct ntb_transport_qp *qp;
> >>> +
> >>> +	if (qp_num < 0 || qp_num >= nt->qp_count)
> >>> +		return;
> >>> +
> >>> +	qp = &nt->qp_vec[qp_num];
> >>> +	if (WARN_ON(!qp))
> >>> +		return;
> >>> +
> >>> +	queue_work(nt->wq, &qp->read_work);
> >>> +	queue_work(nt->wq, &qp->write_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	int rc;
> >>> +
> >>> +	if (!use_remote_edma || nt->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
> >>> +		return 0;
> >>> +
> >>> +	rc = ntb_edma_setup_peer(ndev);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to enable remote eDMA: %d\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &nt->edma);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	nt->remote_edma_mode = REMOTE_EDMA_RC;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	struct pci_epc *epc;
> >>> +	int rc;
> >>> +
> >>> +	if (!use_remote_edma || nt->remote_edma_mode == REMOTE_EDMA_EP)
> >>> +		return 0;
> >>> +
> >>> +	/* Only EP side can return pci_epc */
> >>> +	epc = ntb_get_pci_epc(ndev);
> >>> +	if (!epc)
> >>> +		return 0;
> >>> +
> >>> +	rc = ntb_edma_setup_mws(ndev);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev,
> >>> +			"Failed to set up memory window for eDMA: %d\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	rc = ntb_edma_setup_isr(&pdev->dev, &epc->dev, ntb_transport_edma_isr, nt);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to setup eDMA ISR (%d)\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	nt->remote_edma_mode = REMOTE_EDMA_EP;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_setup_qp_mw(struct ntb_transport_ctx *nt,
> >>> +					  unsigned int qp_num)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_transport_mw *mw;
> >>> +	unsigned int mw_num, mw_count, qp_count;
> >>> +	unsigned int qp_offset, rx_info_offset;
> >>> +	unsigned int mw_size, mw_size_per_qp;
> >>> +	unsigned int num_qps_mw;
> >>> +	size_t edma_total;
> >>> +	unsigned int i;
> >>> +	int node;
> >>> +
> >>> +	mw_count = nt->mw_count;
> >>> +	qp_count = nt->qp_count;
> >>> +
> >>> +	mw_num = QP_TO_MW(nt, qp_num);
> >>> +	mw = &nt->mw_vec[mw_num];
> >>> +
> >>> +	if (!mw->virt_addr)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	if (mw_num < qp_count % mw_count)
> >>> +		num_qps_mw = qp_count / mw_count + 1;
> >>> +	else
> >>> +		num_qps_mw = qp_count / mw_count;
> >>> +
> >>> +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
> >>> +	if (max_mw_size && mw_size > max_mw_size)
> >>> +		mw_size = max_mw_size;
> >>> +
> >>> +	mw_size_per_qp = round_down((unsigned int)mw_size / num_qps_mw, SZ_64);
> >>> +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
> >>> +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
> >>> +
> >>> +	qp->tx_mw_size = mw_size_per_qp;
> >>> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> >>> +	if (!qp->tx_mw)
> >>> +		return -EINVAL;
> >>> +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
> >>> +	if (!qp->tx_mw_phys)
> >>> +		return -EINVAL;
> >>> +	qp->rx_info = qp->tx_mw + rx_info_offset;
> >>> +	qp->rx_buff = mw->virt_addr + qp_offset;
> >>> +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
> >>> +
> >>> +	/* Due to housekeeping, there must be at least 2 buffs */
> >>> +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> >>> +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> >>> +
> >>> +	/* In eDMA mode, decouple from MW sizing and force ring-sized entries */
> >>> +	edma_total = 2 * sizeof(struct ntb_edma_ring);
> >>> +	if (rx_info_offset < edma_total) {
> >>> +		dev_err(&ndev->dev, "Ring space requires %luB (>=%uB)\n",
> >>> +			edma_total, rx_info_offset);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +	qp->tx_max_entry = NTB_EDMA_RING_ENTRIES;
> >>> +	qp->rx_max_entry = NTB_EDMA_RING_ENTRIES;
> >>> +
> >>> +	/*
> >>> +	 * Checking to see if we have more entries than the default.
> >>> +	 * We should add additional entries if that is the case so we
> >>> +	 * can be in sync with the transport frames.
> >>> +	 */
> >>> +	node = dev_to_node(&ndev->dev);
> >>> +	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
> >>> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
> >>> +		if (!entry)
> >>> +			return -ENOMEM;
> >>> +
> >>> +		entry->qp = qp;
> >>> +		INIT_WORK(&entry->dma_work, ntb_transport_edma_rc_dma_work);
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> >>> +			     &qp->rx_free_q);
> >>> +		qp->rx_alloc_entry++;
> >>> +	}
> >>> +
> >>> +	memset(qp->rx_buff, 0, edma_total);
> >>> +
> >>> +	qp->rx_pkts = 0;
> >>> +	qp->tx_pkts = 0;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_ep_read_complete(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_edma_desc *in;
> >>> +	unsigned int len;
> >>> +	u32 idx;
> >>> +
> >>> +	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_RD_EP_I(qp)),
> >>> +				     qp->rd_cons) == 0)
> >>> +		return 0;
> >>> +
> >>> +	idx = ntb_edma_ring_idx(qp->rd_cons);
> >>> +	in = NTB_DESC_RD_EP_I(qp, idx);
> >>> +	if (!(in->flags & DESC_DONE_FLAG))
> >>> +		return 0;
> >>> +
> >>> +	in->flags = 0;
> >>> +	len = in->len; /* might be smaller than entry->len */
> >>> +
> >>> +	entry = (struct ntb_queue_entry *)(in->data);
> >>> +	if (WARN_ON(!entry))
> >>> +		return 0;
> >>> +
> >>> +	if (in->flags & LINK_DOWN_FLAG) {
> >>> +		ntb_qp_link_down(qp);
> >>> +		qp->rd_cons++;
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> >>> +		return 1;
> >>> +	}
> >>> +
> >>> +	dma_unmap_single(dma_dev, entry->addr, entry->len, DMA_FROM_DEVICE);
> >>> +
> >>> +	qp->rx_bytes += len;
> >>> +	qp->rx_pkts++;
> >>> +	qp->rd_cons++;
> >>> +
> >>> +	if (qp->rx_handler && qp->client_ready)
> >>> +		qp->rx_handler(qp, qp->cb_data, entry->cb_data, len);
> >>> +
> >>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> >>> +	return 1;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_ep_write_complete(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_edma_desc *in;
> >>> +	u32 idx;
> >>> +
> >>> +	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_WR_EP_I(qp)),
> >>> +				     qp->wr_cons) == 0)
> >>> +		return 0;
> >>> +
> >>> +	idx = ntb_edma_ring_idx(qp->wr_cons);
> >>> +	in = NTB_DESC_WR_EP_I(qp, idx);
> >>> +
> >>> +	entry = (struct ntb_queue_entry *)(in->data);
> >>> +	if (WARN_ON(!entry))
> >>> +		return 0;
> >>> +
> >>> +	qp->wr_cons++;
> >>> +
> >>> +	if (qp->tx_handler)
> >>> +		qp->tx_handler(qp, qp->cb_data, entry->cb_data, entry->len);
> >>> +
> >>> +	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> >>> +	return 1;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_ep_read_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, read_work);
> >>> +	unsigned int i;
> >>> +
> >>> +	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
> >>> +		if (!ntb_transport_edma_ep_read_complete(qp))
> >>> +			break;
> >>> +	}
> >>> +
> >>> +	if (ntb_transport_edma_ep_read_complete(qp))
> >>> +		queue_work(qp->transport->wq, &qp->read_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_ep_write_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, write_work);
> >>> +	unsigned int i;
> >>> +
> >>> +	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
> >>> +		if (!ntb_transport_edma_ep_write_complete(qp))
> >>> +			break;
> >>> +	}
> >>> +
> >>> +	if (ntb_transport_edma_ep_write_complete(qp))
> >>> +		queue_work(qp->transport->wq, &qp->write_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_write_complete_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, write_work);
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_edma_desc *in;
> >>> +	unsigned int len;
> >>> +	void *cb_data;
> >>> +	u32 idx;
> >>> +
> >>> +	while (ntb_edma_ring_used_entry(READ_ONCE(qp->wr_issue),
> >>> +					qp->wr_cons) != 0) {
> >>> +		/* Paired with smp_wmb() in ntb_transport_edma_rc_poll() */
> >>> +		smp_rmb();
> >>> +
> >>> +		idx = ntb_edma_ring_idx(qp->wr_cons);
> >>> +		in = NTB_DESC_WR_RC_I(qp, idx);
> >>> +		entry = (struct ntb_queue_entry *)READ_ONCE(in->data);
> >>> +		if (!entry || !(entry->flags & DESC_DONE_FLAG))
> >>> +			break;
> >>> +
> >>> +		in->data = 0;
> >>> +
> >>> +		cb_data = entry->cb_data;
> >>> +		len = entry->len;
> >>> +
> >>> +		iowrite32(++qp->wr_cons, NTB_TAIL_WR_RC_O(qp));
> >>> +
> >>> +		if (unlikely(entry->flags & LINK_DOWN_FLAG)) {
> >>> +			ntb_qp_link_down(qp);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		ntb_transport_edma_notify_peer(qp);
> >>> +
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> >>> +
> >>> +		if (qp->rx_handler && qp->client_ready)
> >>> +			qp->rx_handler(qp, qp->cb_data, cb_data, len);
> >>> +
> >>> +		/* stat updates */
> >>> +		qp->rx_bytes += len;
> >>> +		qp->rx_pkts++;
> >>> +	}
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_write_cb(void *data,
> >>> +					   const struct dmaengine_result *res)
> >>> +{
> >>> +	struct ntb_queue_entry *entry = data;
> >>> +	struct ntb_transport_qp *qp = entry->qp;
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	enum dmaengine_tx_result dma_err = res->result;
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +
> >>> +	switch (dma_err) {
> >>> +	case DMA_TRANS_READ_FAILED:
> >>> +	case DMA_TRANS_WRITE_FAILED:
> >>> +	case DMA_TRANS_ABORTED:
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		break;
> >>> +	case DMA_TRANS_NOERROR:
> >>> +	default:
> >>> +		break;
> >>> +	}
> >>> +	dma_unmap_sg(dma_dev, &entry->sgl, 1, DMA_FROM_DEVICE);
> >>> +	sg_dma_address(&entry->sgl) = 0;
> >>> +
> >>> +	entry->flags |= DESC_DONE_FLAG;
> >>> +
> >>> +	queue_work(nt->wq, &qp->write_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_read_complete_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, read_work);
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	unsigned int len;
> >>> +	void *cb_data;
> >>> +	u32 idx;
> >>> +
> >>> +	while (ntb_edma_ring_used_entry(READ_ONCE(qp->rd_issue),
> >>> +					qp->rd_cons) != 0) {
> >>> +		/* Paired with smp_wmb() in ntb_transport_edma_rc_tx_enqueue() */
> >>> +		smp_rmb();
> >>> +
> >>> +		idx = ntb_edma_ring_idx(qp->rd_cons);
> >>> +		in = NTB_DESC_RD_RC_I(qp, idx);
> >>> +		entry = (struct ntb_queue_entry *)in->data;
> >>> +		if (!entry || !(entry->flags & DESC_DONE_FLAG))
> >>> +			break;
> >>> +
> >>> +		in->data = 0;
> >>> +
> >>> +		cb_data = entry->cb_data;
> >>> +		len = entry->len;
> >>> +
> >>> +		out = NTB_DESC_RD_RC_O(qp, idx);
> >>> +
> >>> +		WRITE_ONCE(qp->rd_cons, qp->rd_cons + 1);
> >>> +
> >>> +		/*
> >>> +		 * No need to add barrier in-between to enforce ordering here.
> >>> +		 * The other side proceeds only after both flags and tail are
> >>> +		 * updated.
> >>> +		 */
> >>> +		iowrite32(entry->flags, &out->flags);
> >>> +		iowrite32(qp->rd_cons, NTB_TAIL_RD_RC_O(qp));
> >>> +
> >>> +		ntb_transport_edma_notify_peer(qp);
> >>> +
> >>> +		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> >>> +			     &qp->tx_free_q);
> >>> +
> >>> +		if (qp->tx_handler)
> >>> +			qp->tx_handler(qp, qp->cb_data, cb_data, len);
> >>> +
> >>> +		/* stat updates */
> >>> +		qp->tx_bytes += len;
> >>> +		qp->tx_pkts++;
> >>> +	}
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_read_cb(void *data,
> >>> +					  const struct dmaengine_result *res)
> >>> +{
> >>> +	struct ntb_queue_entry *entry = data;
> >>> +	struct ntb_transport_qp *qp = entry->qp;
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	enum dmaengine_tx_result dma_err = res->result;
> >>> +
> >>> +	switch (dma_err) {
> >>> +	case DMA_TRANS_READ_FAILED:
> >>> +	case DMA_TRANS_WRITE_FAILED:
> >>> +	case DMA_TRANS_ABORTED:
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		break;
> >>> +	case DMA_TRANS_NOERROR:
> >>> +	default:
> >>> +		break;
> >>> +	}
> >>> +	dma_unmap_sg(dma_dev, &entry->sgl, 1, DMA_TO_DEVICE);
> >>> +	sg_dma_address(&entry->sgl) = 0;
> >>> +
> >>> +	entry->flags |= DESC_DONE_FLAG;
> >>> +
> >>> +	queue_work(nt->wq, &qp->read_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rc_write_start(struct device *d,
> >>> +					     struct dma_chan *chan, size_t len,
> >>> +					     dma_addr_t ep_src, void *rc_dst,
> >>> +					     struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct scatterlist *sgl = &entry->sgl;
> >>> +	struct dma_async_tx_descriptor *txd;
> >>> +	struct dma_slave_config cfg;
> >>> +	dma_cookie_t cookie;
> >>> +	int nents, rc;
> >>> +
> >>> +	if (!d)
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!chan)
> >>> +		return -ENXIO;
> >>> +
> >>> +	if (WARN_ON(!ep_src || !rc_dst))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (WARN_ON(sg_dma_address(sgl)))
> >>> +		return -EINVAL;
> >>> +
> >>> +	sg_init_one(sgl, rc_dst, len);
> >>> +	nents = dma_map_sg(d, sgl, 1, DMA_FROM_DEVICE);
> >>> +	if (nents <= 0)
> >>> +		return -EIO;
> >>> +
> >>> +	memset(&cfg, 0, sizeof(cfg));
> >>> +	cfg.src_addr       = ep_src;
> >>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.direction      = DMA_DEV_TO_MEM;
> >>> +	rc = dmaengine_slave_config(chan, &cfg);
> >>> +	if (rc)
> >>> +		goto out_unmap;
> >>> +
> >>> +	txd = dmaengine_prep_slave_sg(chan, sgl, 1, DMA_DEV_TO_MEM,
> >>> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> >>> +	if (!txd) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +
> >>> +	txd->callback_result = ntb_transport_edma_rc_write_cb;
> >>> +	txd->callback_param = entry;
> >>> +
> >>> +	cookie = dmaengine_submit(txd);
> >>> +	if (dma_submit_error(cookie)) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +	dma_async_issue_pending(chan);
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	dma_unmap_sg(d, sgl, 1, DMA_FROM_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rc_read_start(struct device *d,
> >>> +					    struct dma_chan *chan, size_t len,
> >>> +					    void *rc_src, dma_addr_t ep_dst,
> >>> +					    struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct scatterlist *sgl = &entry->sgl;
> >>> +	struct dma_async_tx_descriptor *txd;
> >>> +	struct dma_slave_config cfg;
> >>> +	dma_cookie_t cookie;
> >>> +	int nents, rc;
> >>> +
> >>> +	if (!d)
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!chan)
> >>> +		return -ENXIO;
> >>> +
> >>> +	if (WARN_ON(!rc_src || !ep_dst))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (WARN_ON(sg_dma_address(sgl)))
> >>> +		return -EINVAL;
> >>> +
> >>> +	sg_init_one(sgl, rc_src, len);
> >>> +	nents = dma_map_sg(d, sgl, 1, DMA_TO_DEVICE);
> >>> +	if (nents <= 0)
> >>> +		return -EIO;
> >>> +
> >>> +	memset(&cfg, 0, sizeof(cfg));
> >>> +	cfg.dst_addr       = ep_dst;
> >>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.direction      = DMA_MEM_TO_DEV;
> >>> +	rc = dmaengine_slave_config(chan, &cfg);
> >>> +	if (rc)
> >>> +		goto out_unmap;
> >>> +
> >>> +	txd = dmaengine_prep_slave_sg(chan, sgl, 1, DMA_MEM_TO_DEV,
> >>> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> >>> +	if (!txd) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +
> >>> +	txd->callback_result = ntb_transport_edma_rc_read_cb;
> >>> +	txd->callback_param = entry;
> >>> +
> >>> +	cookie = dmaengine_submit(txd);
> >>> +	if (dma_submit_error(cookie)) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +	dma_async_issue_pending(chan);
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	dma_unmap_sg(d, sgl, 1, DMA_TO_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_dma_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_queue_entry *entry = container_of(
> >>> +				work, struct ntb_queue_entry, dma_work);
> >>> +	struct ntb_transport_qp *qp = entry->qp;
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct dma_chan *chan;
> >>> +	int rc;
> >>> +
> >>> +	chan = ntb_edma_pick_chan(&nt->edma, REMOTE_EDMA_WRITE);
> >>> +	rc = ntb_transport_edma_rc_write_start(dma_dev, chan, entry->len,
> >>> +					       entry->addr, entry->buf, entry);
> >>> +	if (rc) {
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		entry->flags |= DESC_DONE_FLAG;
> >>> +		queue_work(nt->wq, &qp->write_work);
> >>> +		return;
> >>> +	}
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rc_poll(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	unsigned int budget = NTB_EDMA_MAX_POLL;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_edma_desc *in;
> >>> +	dma_addr_t ep_src;
> >>> +	u32 len, idx;
> >>> +
> >>> +	while (budget--) {
> >>> +		if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_HEAD_WR_RC_I(qp)),
> >>> +					     qp->wr_issue) == 0)
> >>> +			break;
> >>> +
> >>> +		idx = ntb_edma_ring_idx(qp->wr_issue);
> >>> +		in = NTB_DESC_WR_RC_I(qp, idx);
> >>> +
> >>> +		len = READ_ONCE(in->len);
> >>> +		ep_src = (dma_addr_t)READ_ONCE(in->addr);
> >>> +
> >>> +		/* Prepare 'entry' for write completion */
> >>> +		entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);
> >>> +		if (!entry) {
> >>> +			qp->rx_err_no_buf++;
> >>> +			break;
> >>> +		}
> >>> +		if (WARN_ON(entry->flags & DESC_DONE_FLAG))
> >>> +			entry->flags &= ~DESC_DONE_FLAG;
> >>> +		entry->len = len; /* NB. entry->len can be <=0 */
> >>> +		entry->addr = ep_src;
> >>> +
> >>> +		/*
> >>> +		 * ntb_transport_edma_rc_write_complete_work() checks entry->flags
> >>> +		 * so it needs to be set before wr_issue++.
> >>> +		 */
> >>> +		in->data = (uintptr_t)entry;
> >>> +
> >>> +		/* Ensure in->data visible before wr_issue++ */
> >>> +		smp_wmb();
> >>> +
> >>> +		WRITE_ONCE(qp->wr_issue, qp->wr_issue + 1);
> >>> +
> >>> +		if (!len) {
> >>> +			entry->flags |= DESC_DONE_FLAG;
> >>> +			queue_work(nt->wq, &qp->write_work);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		if (in->flags & LINK_DOWN_FLAG) {
> >>> +			dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
> >>> +			entry->flags |= DESC_DONE_FLAG | LINK_DOWN_FLAG;
> >>> +			queue_work(nt->wq, &qp->write_work);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		queue_work(nt->wq, &entry->dma_work);
> >>> +	}
> >>> +
> >>> +	if (!budget)
> >>> +		tasklet_schedule(&qp->rxc_db_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rc_tx_enqueue(struct ntb_transport_qp *qp,
> >>> +					    struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	unsigned int len = entry->len;
> >>> +	struct dma_chan *chan;
> >>> +	u32 issue, idx, head;
> >>> +	dma_addr_t ep_dst;
> >>> +	int rc;
> >>> +
> >>> +	WARN_ON_ONCE(entry->flags & DESC_DONE_FLAG);
> >>> +
> >>> +	scoped_guard(spinlock_irqsave, &qp->rc_lock) {
> >>> +		head = READ_ONCE(*NTB_HEAD_RD_RC_I(qp));
> >>> +		issue = qp->rd_issue;
> >>> +		if (ntb_edma_ring_used_entry(head, issue) == 0) {
> >>> +			qp->tx_ring_full++;
> >>> +			return -ENOSPC;
> >>> +		}
> >>> +
> >>> +		/*
> >>> +		 * ntb_transport_edma_rc_read_complete_work() checks entry->flags
> >>> +		 * so it needs to be set before rd_issue++.
> >>> +		 */
> >>> +		idx = ntb_edma_ring_idx(issue);
> >>> +		in = NTB_DESC_RD_RC_I(qp, idx);
> >>> +		in->data = (uintptr_t)entry;
> >>> +
> >>> +		/* Make in->data visible before rd_issue++ */
> >>> +		smp_wmb();
> >>> +
> >>> +		WRITE_ONCE(qp->rd_issue, qp->rd_issue + 1);
> >>> +	}
> >>> +
> >>> +	/* Publish the final transfer length to the EP side */
> >>> +	out = NTB_DESC_RD_RC_O(qp, idx);
> >>> +	iowrite32(len, &out->len);
> >>> +	ioread32(&out->len);
> >>> +
> >>> +	if (unlikely(!len)) {
> >>> +		entry->flags |= DESC_DONE_FLAG;
> >>> +		queue_work(nt->wq, &qp->read_work);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	/* Paired with dma_wmb() in ntb_transport_edma_ep_rx_enqueue() */
> >>> +	dma_rmb();
> >>> +
> >>> +	/* kick remote eDMA read transfer */
> >>> +	ep_dst = (dma_addr_t)in->addr;
> >>> +	chan = ntb_edma_pick_chan(&nt->edma, REMOTE_EDMA_READ);
> >>> +	rc = ntb_transport_edma_rc_read_start(dma_dev, chan, len,
> >>> +					      entry->buf, ep_dst, entry);
> >>> +	if (rc) {
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		entry->flags |= DESC_DONE_FLAG;
> >>> +		queue_work(nt->wq, &qp->read_work);
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_ep_tx_enqueue(struct ntb_transport_qp *qp,
> >>> +					    struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	unsigned int len = entry->len;
> >>> +	dma_addr_t ep_src = 0;
> >>> +	u32 idx;
> >>> +	int rc;
> >>> +
> >>> +	if (likely(len)) {
> >>> +		ep_src = dma_map_single(dma_dev, entry->buf, len,
> >>> +					DMA_TO_DEVICE);
> >>> +		rc = dma_mapping_error(dma_dev, ep_src);
> >>> +		if (rc)
> >>> +			return rc;
> >>> +	}
> >>> +
> >>> +	scoped_guard(spinlock_irqsave, &qp->ep_tx_lock) {
> >>> +		if (ntb_edma_ring_full(qp->wr_prod, qp->wr_cons)) {
> >>> +			rc = -ENOSPC;
> >>> +			qp->tx_ring_full++;
> >>> +			goto out_unmap;
> >>> +		}
> >>> +
> >>> +		idx = ntb_edma_ring_idx(qp->wr_prod);
> >>> +		in  = NTB_DESC_WR_EP_I(qp, idx);
> >>> +		out = NTB_DESC_WR_EP_O(qp, idx);
> >>> +
> >>> +		WARN_ON(in->flags & DESC_DONE_FLAG);
> >>> +		WARN_ON(entry->flags & DESC_DONE_FLAG);
> >>> +		in->flags = 0;
> >>> +		in->data  = (uintptr_t)entry;
> >>> +		entry->addr  = ep_src;
> >>> +
> >>> +		iowrite32(len,          &out->len);
> >>> +		iowrite32(entry->flags, &out->flags);
> >>> +		iowrite64(ep_src,       &out->addr);
> >>> +		WRITE_ONCE(qp->wr_prod, qp->wr_prod + 1);
> >>> +
> >>> +		dma_wmb();
> >>> +		iowrite32(qp->wr_prod, NTB_HEAD_WR_EP_O(qp));
> >>> +
> >>> +		qp->tx_bytes += len;
> >>> +		qp->tx_pkts++;
> >>> +	}
> >>> +
> >>> +	ntb_transport_edma_notify_peer(qp);
> >>> +
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	if (likely(len))
> >>> +		dma_unmap_single(dma_dev, ep_src, len, DMA_TO_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_tx_enqueue(struct ntb_transport_qp *qp,
> >>> +					 struct ntb_queue_entry *entry,
> >>> +					 void *cb, void *data, unsigned int len,
> >>> +					 unsigned int flags)
> >>> +{
> >>> +	struct device *dma_dev;
> >>> +
> >>> +	if (entry->addr) {
> >>> +		/* Deferred unmap */
> >>> +		dma_dev = get_dma_dev(qp->ndev);
> >>> +		dma_unmap_single(dma_dev, entry->addr, entry->len, DMA_TO_DEVICE);
> >>> +	}
> >>> +
> >>> +	entry->cb_data = cb;
> >>> +	entry->buf = data;
> >>> +	entry->len = len;
> >>> +	entry->flags = flags;
> >>> +	entry->errors = 0;
> >>> +	entry->addr = 0;
> >>> +
> >>> +	WARN_ON_ONCE(!ntb_qp_edma_enabled(qp));
> >>> +
> >>> +	if (ntb_qp_edma_is_ep(qp))
> >>> +		return ntb_transport_edma_ep_tx_enqueue(qp, entry);
> >>> +	else
> >>> +		return ntb_transport_edma_rc_tx_enqueue(qp, entry);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_ep_rx_enqueue(struct ntb_transport_qp *qp,
> >>> +					    struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	unsigned int len = entry->len;
> >>> +	void *data = entry->buf;
> >>> +	dma_addr_t ep_dst;
> >>> +	u32 idx;
> >>> +	int rc;
> >>> +
> >>> +	ep_dst = dma_map_single(dma_dev, data, len, DMA_FROM_DEVICE);
> >>> +	rc = dma_mapping_error(dma_dev, ep_dst);
> >>> +	if (rc)
> >>> +		return rc;
> >>> +
> >>> +	scoped_guard(spinlock_bh, &qp->ep_rx_lock) {
> >>> +		if (ntb_edma_ring_full(READ_ONCE(qp->rd_prod),
> >>> +				       READ_ONCE(qp->rd_cons))) {
> >>> +			rc = -ENOSPC;
> >>> +			goto out_unmap;
> >>> +		}
> >>> +
> >>> +		idx = ntb_edma_ring_idx(qp->rd_prod);
> >>> +		in = NTB_DESC_RD_EP_I(qp, idx);
> >>> +		out = NTB_DESC_RD_EP_O(qp, idx);
> >>> +
> >>> +		iowrite32(len, &out->len);
> >>> +		iowrite64(ep_dst, &out->addr);
> >>> +
> >>> +		WARN_ON(in->flags & DESC_DONE_FLAG);
> >>> +		in->data = (uintptr_t)entry;
> >>> +		entry->addr = ep_dst;
> >>> +
> >>> +		/* Ensure len/addr are visible before the head update */
> >>> +		dma_wmb();
> >>> +
> >>> +		WRITE_ONCE(qp->rd_prod, qp->rd_prod + 1);
> >>> +		iowrite32(qp->rd_prod, NTB_HEAD_RD_EP_O(qp));
> >>> +	}
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	dma_unmap_single(dma_dev, ep_dst, len, DMA_FROM_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rx_enqueue(struct ntb_transport_qp *qp,
> >>> +					 struct ntb_queue_entry *entry)
> >>> +{
> >>> +	int rc;
> >>> +
> >>> +	/* The behaviour is the same as the default backend for RC side */
> >>> +	if (ntb_qp_edma_is_ep(qp)) {
> >>> +		rc = ntb_transport_edma_ep_rx_enqueue(qp, entry);
> >>> +		if (rc) {
> >>> +			ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> >>> +				     &qp->rx_free_q);
> >>> +			return rc;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
> >>> +
> >>> +	if (qp->active)
> >>> +		tasklet_schedule(&qp->rxc_db_work);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rx_poll(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +
> >>> +	if (ntb_qp_edma_is_rc(qp))
> >>> +		ntb_transport_edma_rc_poll(qp);
> >>> +	else if (ntb_qp_edma_is_ep(qp)) {
> >>> +		/*
> >>> +		 * Make sure we poll the rings even if an eDMA interrupt is
> >>> +		 * cleared on the RC side earlier.
> >>> +		 */
> >>> +		queue_work(nt->wq, &qp->read_work);
> >>> +		queue_work(nt->wq, &qp->write_work);
> >>> +	} else
> >>> +		/* Unreachable */
> >>> +		WARN_ON_ONCE(1);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_read_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, read_work);
> >>> +
> >>> +	if (ntb_qp_edma_is_rc(qp))
> >>> +		ntb_transport_edma_rc_read_complete_work(work);
> >>> +	else if (ntb_qp_edma_is_ep(qp))
> >>> +		ntb_transport_edma_ep_read_work(work);
> >>> +	else
> >>> +		/* Unreachable */
> >>> +		WARN_ON_ONCE(1);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_write_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = container_of(
> >>> +				work, struct ntb_transport_qp, write_work);
> >>> +
> >>> +	if (ntb_qp_edma_is_rc(qp))
> >>> +		ntb_transport_edma_rc_write_complete_work(work);
> >>> +	else if (ntb_qp_edma_is_ep(qp))
> >>> +		ntb_transport_edma_ep_write_work(work);
> >>> +	else
> >>> +		/* Unreachable */
> >>> +		WARN_ON_ONCE(1);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_init_queue(struct ntb_transport_ctx *nt,
> >>> +					  unsigned int qp_num)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> >>> +
> >>> +	qp->wr_cons = 0;
> >>> +	qp->rd_cons = 0;
> >>> +	qp->wr_prod = 0;
> >>> +	qp->rd_prod = 0;
> >>> +	qp->wr_issue = 0;
> >>> +	qp->rd_issue = 0;
> >>> +
> >>> +	INIT_WORK(&qp->db_work, ntb_transport_edma_db_work);
> >>> +	INIT_WORK(&qp->read_work, ntb_transport_edma_read_work);
> >>> +	INIT_WORK(&qp->write_work, ntb_transport_edma_write_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_create_queue(struct ntb_transport_ctx *nt,
> >>> +					    struct ntb_transport_qp *qp)
> >>> +{
> >>> +	spin_lock_init(&qp->ep_tx_lock);
> >>> +	spin_lock_init(&qp->ep_rx_lock);
> >>> +	spin_lock_init(&qp->rc_lock);
> >>> +}
> >>> +
> >>> +static const struct ntb_transport_backend_ops edma_backend_ops = {
> >>> +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> >>> +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> >>> +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> >>> +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> >>> +	.rx_poll = ntb_transport_edma_rx_poll,
> >>> +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> >>> +};
> >>> +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> >>> +
> >>>  /**
> >>>   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> >>>   * @qp: NTB transport layer queue to be enabled
> >>
> 

