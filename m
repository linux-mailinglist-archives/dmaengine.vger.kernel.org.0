Return-Path: <dmaengine+bounces-7448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5158C9A3A5
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826303A53A0
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21152FFFB5;
	Tue,  2 Dec 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CwW+T2T1"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1A2F6189;
	Tue,  2 Dec 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656410; cv=fail; b=IMa5obr14OUY6zIaKcfUB6ONWt4mJljxNfesswGFoZD8aauDZURZsHuuBB3s7HWeC5suUPca3zY04F3niiFvUjAuSQpWFIE+rgMFxK0FgnqgKwvBaUzcQwscLYrZkUSl5OmzvCw9xNoS8mUTX3S56mwn6bF9CYJyEPqH1eyLkpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656410; c=relaxed/simple;
	bh=hJGmT5bQH72lQumBVouQOjRa152h40z0yW8dz4I+Bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bie/TTTdLWXwsI9pLQhaXfOrqZU5HTbarNnbrgGzplB7es712/p2Vjfly2iJJqtrW9Er6rFSEWpCdpuQ5hllHSMqHVrgEfk25TVg7PsjPW3xVSQvO5cuar+0yUDr6CQa987ciGTZW1zkz0N8dXMCGHMMtO5eTSlS8XJRVjKLM1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CwW+T2T1; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOgQPSlmxrE73RBqZDupaUc3AEZKNUu8qRWjO81oo8RtAfuchyyifpDXxZYzSIAagOlgFE7VRwTG5fxL7GiulsrlG6Oe3i0ycK4d9fAykDcg8ZKYQk2/t2ENaM2apjAOf+4Ff950sqewiUGqGSB7RoR6el/+CbHF1Z+vgQMxN9bUUUYoCW5dupEPvUsojGjgsPnYVX4TaNakpo6cXBg7Tk5qa1E5X3WCNuiCBOOmJle5ikNPlq9RkH4+a2elF+q9E0nO1Wqs3IJtf5kn2Z9hfzlOpFIJT9oWuws/UP9aM+RoLvX6EuMO87DBvEalWOuCCRm1/9zjFQvb4YuQ1gILqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4g2Xe7M+wEVJBbEUizyxmI5sWvKJ1fdPZkk3ckr4hg=;
 b=PdJ9SMk1Mqe9C6yXuUdU3pTdMEBy5bJah4QYnakCXPXr9yxw5IQvSuaQLVmYkXBp+3Jis7RFvmlgn0jhLwYojo9qoTJd4V/wLbsZTUAD6vUjmdMRZKZS2YTTpY1I/+8DwEaxLInYZXi2VicGUfdyQbsIUtjaL+ZGlJW6mIkcOPOZ+nNx3UdqSqXS98wmEtU7LSBHSF44zdBKNOQ9rtQRelDg6Q/Xq5OXHm0anH/KOuu4DcaVrwGNyezvjRF5+bSU3vSJKnoClFomF6xTBbPp+C1bY3vivEG4/fIMbTFxCz3w/oAX0RfYM62VInnSlITPvTKk6yfpXb855Jr1Gv8qVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4g2Xe7M+wEVJBbEUizyxmI5sWvKJ1fdPZkk3ckr4hg=;
 b=CwW+T2T1buJIhazuEUnCmzYYVDAX9tEHHxNiSl8YPFNS+jRNIEnF3WABssD0vQ8/9Zy8Zthh5wc/lRQDgodlOLI1RXz+uRV2Hd+cQentFJgKcqntBSaBI0/4WBsJtptvVRcwFolN4fEjpELCzkMGXuVhVbmQxHnX7XZfDAm+rDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OSZP286MB2142.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:20:03 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:20:03 +0000
Date: Tue, 2 Dec 2025 15:20:01 +0900
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
Subject: Re: [RFC PATCH v2 00/27] NTB transport backed by remote DW eDMA
Message-ID: <hp4shyyqwjddo54vac6gtau44qyshqw3ez5cqswtu4qhgg3ji3@6bi3rlnbqfz6>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <aS4QkYn+aKphlRFm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS4QkYn+aKphlRFm@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OSZP286MB2142:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a45a58-13f2-40ab-c9af-08de316ad429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfyJDGmilxVIn2ag19mioClAIOY+dH/XhI48TM2uiHqEibV+WuLLqi/4V/QR?=
 =?us-ascii?Q?Z++VdABPcG7llvk5hkXhfZkrbB7puGHCiCB/bi6OxTLZAVXM2jyN1PCJfToL?=
 =?us-ascii?Q?0cXt5e8paW42fz+uoCilyxq+6vf+c7djJzqgYB+BfQBG/oYG+j217iusgCRb?=
 =?us-ascii?Q?gq/BZbFmO1iCEUD/Nyk/ZOpa4XBQQofksXo1eihoWUjR1GHurEcBNLmzGYG0?=
 =?us-ascii?Q?wU2LRafjCf5Ppc9VmeMXF+y0SN6d5bCtayg3LYfH05LIORg1YQLJx07GGSqy?=
 =?us-ascii?Q?ILoHhXJfKlgX3MGeeZokmkSJZGUxOArpohzWoW9E76h3oLrgWAZiGqGwPLQw?=
 =?us-ascii?Q?upRJc+Ex9NgL/+v2QKty2vu3y4jAYuV7p/S4DgTskPhjobvW7jIwytWsGMu/?=
 =?us-ascii?Q?ZiPhdn+3dh7JEByZmOF9x1wIh6ViAn2Bll5xLSz1bMyWyXof1QeWBgRh/Rvl?=
 =?us-ascii?Q?iOoatk/8PrMh+N82R6uUtDnal1/8vRsj3+rJyAUSE1uLlND0H5odu2KHrJ3V?=
 =?us-ascii?Q?T+KGD92ZA7v0FoEsvU8Nu7cmmtkn31mXarqarVTdS9xO4l0qagOzxGsy5VXw?=
 =?us-ascii?Q?R9rC6O49gknEFqT0n7HMvh3AvO9a5xAdZCXULUVflRT27DYap1pUVgE/A9KU?=
 =?us-ascii?Q?gGL1JWWVZJAyyxNmDsXDVNeX5BWybt25aiPTIkighcnHIRGYq60Ko4503EPT?=
 =?us-ascii?Q?jgsE3zgaihw+11/Wjinm5S7yVnW+exCfyw4Ug4IevCRw8SR+S9YV+5LKNPWN?=
 =?us-ascii?Q?M+vXvh8BsEha+8gaH2p9H79nceo+kqScCvHW4nqraNE+Yki8Guxk/g/MAJME?=
 =?us-ascii?Q?pVVpzPo+d//epxo5rFH72Qnk2rzp2B+ZEI+6jrPqiVDMe2sE6g1+Tcmo6LWj?=
 =?us-ascii?Q?5Lebz0w6xjawoeKgdzT8py6Vqv6V1c8zyKFvFYSPVkL3s2cRC3dKRQPbXTee?=
 =?us-ascii?Q?wHuMbSDH3oDu/6pU7gyKXTBYSIEcookXKNmeY42fHviFxkPyrmjm7i5OwpAx?=
 =?us-ascii?Q?w+aqCIfQB8UyhvKvxF8WR+u5GpYIypUoL+gmmkAhA+cQOzuORB2Tfdlk3wox?=
 =?us-ascii?Q?6Nw8EOZ8mBsFXruaOuDCdSdLGLTz7NfZthmluam+04P/Z8cfgH1H7u+Rvn9z?=
 =?us-ascii?Q?3kfWuM8SUYrX0MpIExX6RgsPnE8zUV57/7D1dZu+TyCk8RLXrdhiEUQ5Vz1X?=
 =?us-ascii?Q?7TYl+SejFm3CxvrFsfLqwnWArYtSPxKGSDpprqDiSMTQ1f2jnqbhQDXIsmg5?=
 =?us-ascii?Q?CJk2v0CyuxGLxbTuj3yFkpHCOADiEkcNioBif7yQ2AJ5c3xhcEj2lZYAhhfv?=
 =?us-ascii?Q?mH6lhVIbnyU8NBYlLEXMiqMpNkklmFj+CQMvHJhJVv12hSNrisTHXzfCdgHK?=
 =?us-ascii?Q?5KxDjkADliqAn8dTnRplF9zSVml+e9sjVv2hDqDMsA42D2l4UOpNMwcrF4Lg?=
 =?us-ascii?Q?JPj91jnRVqbiwXQar3oaCA+8L1ERkuTc6Ip58cCc3qGMAsqJXPH0jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgsBhYrOATVo1xuZQ0z7nztdEumcJUUr6uyIWUDUK0AGZ2XLeSmVSzwaDArV?=
 =?us-ascii?Q?ADMyW8JwZOp3sEjnN49eyVLQdoijdp0zzv58qHjau/uW8hEh9wZtt2M2acQp?=
 =?us-ascii?Q?wQ2aGlDSS0rlWvaGefhUcbwbRbk/vFfFCQMXiaz+9KS9iMgGpCpsUywcun6m?=
 =?us-ascii?Q?8+RJvZuZNMKamL1mOc0HnJQEFar1C41xY5E3KTjtHJQE/c+Zz0nsJeHwQ4Yl?=
 =?us-ascii?Q?5/GZx1WVFsAOWanEA/TpU05H9st6dFurYr2g9JJ8HvIg046+6AjBlt3budNI?=
 =?us-ascii?Q?YC+A4+ugTlnnqRDyegWSEvG6F33aC0XvLyI/Lg6cnbsDwQC+Q8vLFaeH93M9?=
 =?us-ascii?Q?GLcVPOAjpX12SdqxdFOdUIoQoJ9HV+UDFnxgsGFHEvvFU/AdB7+4a83RqGsZ?=
 =?us-ascii?Q?tPX5jSsi5mHXOlf8ronX5tHDXe/5ephW52NOmYBsdQQPCSs34Mj5soOKoC4h?=
 =?us-ascii?Q?04AL0Zt4BvALJrEO1Nybt0TpeenhqOsr5qKT7qRZP5xFTWmvRA6ipcNrz+kP?=
 =?us-ascii?Q?PRa8nWxDFiyhzuPd8zXXeZcZKwa7l3MpUljXw6Qj4o0gR1TrZ+b1dqP5SeZ9?=
 =?us-ascii?Q?vkcXqYE7CuMLekqvlz4O9D5ur0cXBVQYt0angaxdEWhGCpfWT+Pq3wdI+LeM?=
 =?us-ascii?Q?z/99qVQDE3BLqW41+T2p0WArIa/jJOiKYMefT3kfcv4FzyjNSr3yPqyzx+9z?=
 =?us-ascii?Q?na4DKkbRLFGZWrwwQDYXWA5cHWH/NNxHXDQs/U8ykP45XlgkiuPnV9n80ki/?=
 =?us-ascii?Q?bD+ig96Yfr5nXrQEba+HUb6Srt030p02CDla2SeUR7wcb+pgllIi3AXomsyx?=
 =?us-ascii?Q?LenXJZwNfSMJJ42SkVvB3sBrgLWMWAM8lqrAngg6iA60iRfiSl5T00NBUw2m?=
 =?us-ascii?Q?JToFlo/UWTsrZR3aIZXh6I42+jJKvZLBVQCS3QTMYH1g/ZsUyv/w9/UyLPRL?=
 =?us-ascii?Q?fsE3EZYOdcLK8sJLPOBL+siovy4FA4ky8ddMXoaQCHXrQs4NDtGBDmJPg87H?=
 =?us-ascii?Q?0s/QNobnhqeag+ZiMBG9xt1GGtYTcQrZXlbyLt8MzxXA9eJRnqYPgEuDTnep?=
 =?us-ascii?Q?wsArHtWRJ5y1DcvHdxP30rhpJZyQ4sHEIva01y06EoHenmfruxSMRmnKQwHt?=
 =?us-ascii?Q?iyv9C/XO2hW6NLQ4P3LdNiCH0T5NioRPMTV6miUGWXufDk4bDo4WrDleeWBS?=
 =?us-ascii?Q?xXmu5qz5gI4okXglWgr3LS1fzmgcT6OnLTnEQcpfIX9s3HMaGRc0zxCzefTG?=
 =?us-ascii?Q?m42d2gMctwn5CdnRaJdun14V1nnS5MxBKxk1vYeQvS+uLbQ1O8M8k3WxwsMQ?=
 =?us-ascii?Q?YnXH4c8D61JZFcKIE72iDONo2pNyaCtsTOdoR9D32GKIuQWtBIzHB3T21kvA?=
 =?us-ascii?Q?WOa/WDG/x9D+RcdPJn/EarY4M5gAK9QrNqxnsTEl1yqukQ1FHEAyMiDBC3YX?=
 =?us-ascii?Q?9YygKRXHgvCf0otg8mouMLeH0SG1O9fxrz4BiZ4sMbeLZTlrnlFJiJOKR07+?=
 =?us-ascii?Q?cZU5lIwAXCZiU20OK7qaJ2P7hV1lStkT2PseolBsbv92SGOe3ass2PGJP+2X?=
 =?us-ascii?Q?4GBwzfyGkEHThHHjhJMeHnndtk2A0uCOx5xQk0xEYgrVd6MeGZPe783zwWsh?=
 =?us-ascii?Q?jHU6VYkCS0PcXKeZrVZKpiQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a45a58-13f2-40ab-c9af-08de316ad429
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:20:03.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YZ6PkPvouXOwz061lPqxdZ9BzPEVGKQZoDi2DUEKMtXllgCb0XIUkSiXMJGHDZWhX9RiEl2Yjcwuwe13FtXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2142

On Mon, Dec 01, 2025 at 05:02:57PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:38AM +0900, Koichiro Den wrote:
> > Hi,
> >
> > This is RFC v2 of the NTB/PCI series for Renesas R-Car S4. The ultimate
> > goal is unchanged, i.e. to improve performance between RC and EP
> > (with vNTB) over ntb_transport, but the approach has changed drastically.
> > Based on the feedback from Frank Li in the v1 thread, in particular:
> > https://lore.kernel.org/all/aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810/
> > this RFC v2 instead builds an NTB transport backed by remote eDMA
> > architecture and reshapes the series around it. The RC->EP interruption
> > is now achieved using a dedicated eDMA read channel, so the somewhat
> > "hack"-ish approach in RFC v1 is no longer needed.
> >
> > Compared to RFC v1, this v2 series enables NTB transport backed by
> > remote DW eDMA, so the current ntb_transport handling of Memory Window
> > is no longer needed, and direct DMA transfers between EP and RC are
> > used.
> >
> > I realize this is quite a large series. Sorry for the volume, but for
> > the RFC stage I believe presenting the full picture in a single set
> > helps with reviewing the overall architecture. Once the direction is
> > agreed, I will respin it split by subsystem and topic.
> >
> >
> ...
> >
> > - Before this change:
> >
> >   * ping
> >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
> >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
> >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
> >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
> >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
> >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
> >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
> >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
> >
> >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
> >     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> >     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
> >     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
> >     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
> >
> >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
> >     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
> >     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
> >     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
> >
> >     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
> >
> > - After this change (use_remote_edma=1) [1]:
> >
> >   * ping
> >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.48 ms
> >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.03 ms
> >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.931 ms
> >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.910 ms
> >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.07 ms
> >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
> >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.910 ms
> >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.883 ms
> >
> >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
> >     [  5]   0.00-10.01  sec  3.54 GBytes  3.04 Gbits/sec  0.030 ms  0/58007 (0%)  receiver
> >     [  6]   0.00-10.01  sec  3.71 GBytes  3.19 Gbits/sec  0.453 ms  0/60909 (0%)  receiver
> >     [  9]   0.00-10.01  sec  3.85 GBytes  3.30 Gbits/sec  0.027 ms  0/63072 (0%)  receiver
> >     [ 11]   0.00-10.01  sec  3.26 GBytes  2.80 Gbits/sec  0.070 ms  1/53512 (0.0019%)  receiver
> >     [SUM]   0.00-10.01  sec  14.4 GBytes  12.3 Gbits/sec  0.145 ms  1/235500 (0.00042%)  receiver
> >
> >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
> >     [  5]   0.00-10.03  sec  3.40 GBytes  2.91 Gbits/sec  0.104 ms  15467/71208 (22%)  receiver
> >     [  6]   0.00-10.03  sec  3.08 GBytes  2.64 Gbits/sec  0.176 ms  12097/62609 (19%)  receiver
> >     [  9]   0.00-10.03  sec  3.38 GBytes  2.90 Gbits/sec  0.270 ms  17212/72710 (24%)  receiver
> >     [ 11]   0.00-10.03  sec  2.56 GBytes  2.19 Gbits/sec  0.200 ms  11193/53090 (21%)  receiver
> 
> Almost 10x fast, 2.9G vs 279M? high light this one will bring more peopole
> interesting about this topic.

Thank you for the review!

OK, I'll highlight this in the next iteration.
By the way, my impression is that we can achieve even higher with this remote
eDMA architecture.

> 
> >     [SUM]   0.00-10.03  sec  12.4 GBytes  10.6 Gbits/sec  0.188 ms  55969/259617 (22%)  receiver
> >
> >   [1] configfs settings:
> >       # modprobe pci_epf_vntb dyndbg=+pmf
> >       # cd /sys/kernel/config/pci_ep/
> >       # mkdir functions/pci_epf_vntb/func1
> >       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
> >       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
> >       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
> >       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
> >       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
> >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
> >       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
> >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
> 
> look like, you try to create sub-small mw windows.
> 
> Is it more clean ?
> 
> echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.0
> echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.1
> 
> so wm1.1 natively continue from prevous one.

Thanks for the suggestion.

I was trying to keep the sub-small mw windows referred to in the same way
as normal windows for simplicity and readability, but I agree your proposal
looks intuitive from a User-eXperience point of view.

My only concern is that e.g. {mw1.0, mw1.1, mw2.0} may translate internally
into something like {mw1, mw2, mw3} effectively, and that numbering
mismatch might become confusing when reading or debugging the code.

-Koichiro

> 
> Frank
> 
> >       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
> >       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> >       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
> >       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
> >       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
> >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
> >       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
> >       # echo 1 > controllers/e65d0000.pcie-ep/start
> >
> >
> > Thanks for taking a look.
> >
> >
> > Koichiro Den (27):
> >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> >     access
> >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> >   NTB: epf: Handle mwN_offset for inbound MW regions
> >   PCI: endpoint: Add inbound mapping ops to EPC core
> >   PCI: dwc: ep: Implement EPC inbound mapping support
> >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> >   NTB: Add offset parameter to MW translation APIs
> >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> >     present
> >   NTB: ntb_transport: Support offsetted partial memory windows
> >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> >   NTB: epf: vntb: Implement .get_pci_epc() callback
> >   damengine: dw-edma: Fix MSI data values for multi-vector IMWr
> >     interrupts
> >   NTB: ntb_transport: Use seq_file for QP stats debugfs
> >   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> >   NTB: ntb_transport: Dynamically determine qp count
> >   NTB: ntb_transport: Introduce get_dma_dev() helper
> >   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> >   NTB: ntb_transport: Introduce ntb_transport_backend_ops
> >   PCI: dwc: ep: Cache MSI outbound iATU mapping
> >   NTB: ntb_transport: Introduce remote eDMA backed transport mode
> >   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> >   ntb_netdev: Multi-queue support
> >   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> >   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> >   iommu: ipmmu-vmsa: Add support for reserved regions
> >   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
> >     eDMA
> >   NTB: epf: Add an additional memory window (MW2) barno mapping on
> >     Renesas R-Car
> >
> >  arch/arm64/boot/dts/renesas/Makefile          |    2 +
> >  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   46 +
> >  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
> >  drivers/dma/dw-edma/dw-edma-core.c            |   28 +-
> >  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
> >  drivers/net/ntb_netdev.c                      |  341 ++-
> >  drivers/ntb/Kconfig                           |   11 +
> >  drivers/ntb/Makefile                          |    3 +
> >  drivers/ntb/hw/amd/ntb_hw_amd.c               |    6 +-
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  177 +-
> >  drivers/ntb/hw/idt/ntb_hw_idt.c               |    3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |    6 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |    2 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |    3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |    6 +-
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |    6 +-
> >  drivers/ntb/msi.c                             |    6 +-
> >  drivers/ntb/ntb_edma.c                        |  628 ++++++
> >  drivers/ntb/ntb_edma.h                        |  128 ++
> >  .../{ntb_transport.c => ntb_transport_core.c} | 1829 ++++++++++++++---
> >  drivers/ntb/test/ntb_perf.c                   |    4 +-
> >  drivers/ntb/test/ntb_tool.c                   |    6 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  287 ++-
> >  drivers/pci/controller/dwc/pcie-designware.h  |    7 +
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  229 ++-
> >  drivers/pci/endpoint/pci-epc-core.c           |   44 +
> >  include/linux/ntb.h                           |   39 +-
> >  include/linux/ntb_transport.h                 |   21 +
> >  include/linux/pci-epc.h                       |   11 +
> >  29 files changed, 3415 insertions(+), 523 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
> >  create mode 100644 drivers/ntb/ntb_edma.c
> >  create mode 100644 drivers/ntb/ntb_edma.h
> >  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (59%)
> >
> > --
> > 2.48.1
> >

