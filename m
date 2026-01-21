Return-Path: <dmaengine+bounces-8423-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAAyGA2ScGkaYgAAu9opvQ
	(envelope-from <dmaengine+bounces-8423-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:45:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C153C91
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12ACA72A94A
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A30343203;
	Wed, 21 Jan 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wjCJJPRu"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14335366547;
	Wed, 21 Jan 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984878; cv=fail; b=ludfK9sSgWX15FVzXzv7jDSCECquYhtvXesCbTG0XSH2gNCy6mR6jgKzMCltZMjSLxsDYV3Xak2GLIpQIQ2WwQcfGC6BpXvHiwRr2fTEeRAi6DXALjj76tv6oYu5CJqR8TnLRmmYj/7+k/SwWtFxBKGkWi2TF2dwbKZVqAQ4YQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984878; c=relaxed/simple;
	bh=+G8w9IL86tW8aZZR42c1KtC9YdxqKuc0506uoAtZHYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfHGn6l0AVhKUxqgt7cJOX3qWE+ebp8Ob1lp3xDnmjuTmVfq0yIOEGmsU6bVjMrEfTkMe9QCqoVTBJdR3nK09Ds50P2LTuto32lwPAq3BYyifl9LKDrI8bZCYbI5ofo0cjmcqtHyO6BCYZhX7AHspchc8PHy7mCCok0ePCJwKf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wjCJJPRu; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeRVlpsYvADXzU0hIo59kUntd0kLjsWDwllfKz0OqCzU6KDjEKrw8GPiiCZ++lSKa6hGkTIpmGYMypSMum/hBviv8PPHgUvislee76ryl2iJTesD2JIM4BvuBPxP8qM6YinlPm1NKw1hpa6uhmIpa04zABT/u28ef8ihVoMQj24SaFsitH1ZEB9FS52JvJPBcRyXytfP3thj6zLnTpbUDjSn4+n12sGegrC4MQkuUubbRg2sLDjzC5b+qXSmfZD66oqFxG91MDMpEgDAVTvUSuyc4rTfjpZqnr90U01nv+1v0Lao+ZKSlCwIhaTRcSRRPKjE+h6Wk5BFhIaYOeg5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOSVzEYsXXVLtUtGw3S2fHju9pRo1CgGCLhFI2gHzTE=;
 b=vZagksvoAWZMJBs5acCZpvi5p/ETwCTNdF6YoV6XBibhCPQXqcuJ1jnU/w8DCmQ1mEl27/BQTtA6vAnsZ+GleVxGN8zP/AiBmf1DUsc8qOHqq2/Yt5Lo4Of1PUThBEoC1mQux5fPmUlKzPupozQiC6392OwT2RMIj5WrpsJFR0DJmKF8PfGPlmI0VkDw4iBAplVvdKzEJFvq+EhJBVnANfNnpME0MhdD0RCYmj0C3NlsWYbX3Ju+sQVFT3LbZuwtJFHD2GYXsBeBUn9HMREU/t059n0u9z4zXCnSp26S/xREryQtdUY0FLp5PoQOm/B1WtJAuS2yU/9F++ykgiKCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOSVzEYsXXVLtUtGw3S2fHju9pRo1CgGCLhFI2gHzTE=;
 b=wjCJJPRuJVlRP4L4jjHsSX+cQzg04XSkgmU1SeuiE5vVP9j05cNZakQD0pCWNAseFqmFbL5OWOir0ysiqpuJH4x1R6gyD2H50WpBsc49nRrjYC9y/z7BWqxhae3GSBQiSa31zltFymJfMMDZCTw0lpUYlbITJiaPWs8YJIhXD+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6959.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:343::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:41:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:41:12 +0000
Date: Wed, 21 Jan 2026 17:41:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <tuhaxwmmcjfltih7ckfo2l5ltzicnj6zfc5ka3pvqlljn7ldu2@ibo5eo62lndn>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
 <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
 <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
X-ClientProxiedBy: TY4PR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 183226ac-5552-40e4-6169-08de58c8d516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTUvQ1fcAqlnc9ISfUWYNkWfIOtSAWSAbcwoLAooWCguvh/haowSg0zADT/a?=
 =?us-ascii?Q?8jUkBBKQ4c+GG83TVUO+HlKM1mKACjQ7D9YnEu21lB6fxHBu0DEcTemf8lr8?=
 =?us-ascii?Q?lyaMoIMe8mSM09Z/T2g9zUcz92kGfStOR7CPAlD2WENFVLBh+CCcSfbc8j7e?=
 =?us-ascii?Q?udX8zfAgcmZqLgFsOQs61bqO+oKJNDRVoeAE+dmV5IRpChJSTp+TUwSK7ua2?=
 =?us-ascii?Q?GREwsGwJbIkJQvD7B7jja0yPtkn1s0j0OP9r97fSZbZXlxAHZPXwntElFEbI?=
 =?us-ascii?Q?kaYXHuRCViEvG5zpxfWCrlxmc53JiITiVKciDy5w2CX65MSuBHr1CzLKamIm?=
 =?us-ascii?Q?7+fCsFBwmY+HDl+5GlV9HT6ZuoszHWgUzyHeC0x69c96glLRFcKvf8PI59jU?=
 =?us-ascii?Q?J0V1exTJnPN70wjphH9qINPP07bXP6hdXFMF7fhztAPIDNG1Cg9aUTypUraF?=
 =?us-ascii?Q?w6ygwOu2O/WXGGajhQyn65LbzNhGLca+rBY6ai3rZoo54rsakXJJOqWhpDpG?=
 =?us-ascii?Q?ULlwA3oQaBTbEmzncqeRfzGksQZ4qLp92zOSj/r6rhbGzY8YsxhhhpNmPt49?=
 =?us-ascii?Q?oTcYiZWumcUQN/kDKv4JZFzZgCHoj3aysIJrfWOu8DLa8Sih221drgyOAP6h?=
 =?us-ascii?Q?7L6bNk2XmvYVeVZ2IEuomMCX847amqtelx3BhU6O3FpCvyH7uMoH13wGt4AC?=
 =?us-ascii?Q?a66Njb+D/qxFGRY4sM9bwVRr5MtIFjw/wH7eoxocIOlgEkYYWO+ttWb23JFs?=
 =?us-ascii?Q?DYoPA11qovUegNxH0j6qC+6KeZt25UfrjjHVjLEi226zkkuqqUndGO57BhEU?=
 =?us-ascii?Q?1ZJD6qFpjE+vDfUxIV4o1/hRvCD3uEimUKp6WjU8Hv/s7VDKOwo7WAKwaOtt?=
 =?us-ascii?Q?FDopG7HbJ4EshWoS3P2AGhENz1ddTcDjLgl37BIP7RcCBL56diLrCGlVg9W3?=
 =?us-ascii?Q?QM82vCMLGG1cYoqqvoX0d57fHcaUMjjCEZF+T//h7C1RtzWHKlhMv0/HkdeX?=
 =?us-ascii?Q?m6KNm7HcerhAw59lmmuf6isA+5RijmffD8fFPbYOhknerWrWOOLhw2dU29yW?=
 =?us-ascii?Q?20Ryu8IJURtdgoxlS7TtInGxYuEC9WrXlVPFPSresv4P5AtlgTeY/BrgD+I4?=
 =?us-ascii?Q?SQ3+HgOvp0/87fSkGm71DNxQw4y2RuEwoYa02b064LbsnWB3MjQgQQvqJLB+?=
 =?us-ascii?Q?mFjmQYv0xDXpOfJyj1OB2YDrSDddd0F8LJqt7afD7osfiDxvHmGetTys2pzi?=
 =?us-ascii?Q?bsAOm3bXNjO4bJR+Th6m2vvF3Rbqj3BLGfZXDILSaoVKsZzPrDvH7PzDr4Js?=
 =?us-ascii?Q?UltbRTMzsxFcXTR+17rPui5oAc6NsuQ364wZznW06mgjNqdE1VRk89OaXQMn?=
 =?us-ascii?Q?Zn/RA4gXbarhFGYpjZ24PjDGlTmwhfR9+7xD2A4S4vZAFz5cuqcK9tGsHnTM?=
 =?us-ascii?Q?p7Cvou90YwmUPdxEFMiEGPctpk//UWEtz3TYd6reRVre3xZh8JhsC5Zh357O?=
 =?us-ascii?Q?ONKzUTGWmPY0oZACO2I24IK111TbBBDRLQfRMbl/wfHDFgXIT5BfTlt4H8fQ?=
 =?us-ascii?Q?vYo++uy8UPEpjdecGWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQZ+J2M8Qdxq3ktf4q5zZ+R9nO/Dir2DgQtpn0zQrtzeWmOhgHr9N/tLbbq1?=
 =?us-ascii?Q?iTeq1NEeCJP1K3vw5ZD+x2z5/CkMTUzPSzkkyGJVMWiQjGtJQEv7Oq+iD0lq?=
 =?us-ascii?Q?vcz7POQ1iIoLMwXclenKNbidjB33BA7yMsSp9gVMJoHF4NMZJ/njsHFZcAUs?=
 =?us-ascii?Q?zqDsAP0tf6Mcm2k/yJNMXeShLaL/MUVq4smzQ9itUgajzeqklhpVaRoXohXx?=
 =?us-ascii?Q?oeojOjT4G3hybs/l74aAF71o5YZ7oSbqTkhntGSFPx0vLhYv9lR9f+ZtD54I?=
 =?us-ascii?Q?R4Ciav/T8A08Su9ylWGfWo6FSJbYATPRnjQVL3JS0lKD1juCcVN8HioOUVwL?=
 =?us-ascii?Q?Hyzx72NtEF1ERtS/NvNz54j9sbyw1vQAlevUqmonMTEteTP65bs+m+wBEEfI?=
 =?us-ascii?Q?nK/wyyJxkuqqGQcofbHWTNFWEgzq1YGwoFKJqMEqgF/Azd2x5llOqt9wFf7J?=
 =?us-ascii?Q?ZImFkMWofwQVeTY7L9bHS7jgJScN/cONRyrUgFDqd5s8yU0nSJqzsZk61LPm?=
 =?us-ascii?Q?tONqvFucjJrjARJ8QC+Zc86BjGaiuH08drSrMfosaaKeKlIiebWPR+Bmh9Tp?=
 =?us-ascii?Q?8bUy0XzVrOOm5LB9sxpfOK9+s4VDCQKU4iUe4dq1Ogwl5LI/H6Kx8SpOFWcw?=
 =?us-ascii?Q?WjBqNfS+x4pTnIEaCMws1AJPCL1i4Rah6KwdK2dNHKblGDFybl2BtzuP5mzj?=
 =?us-ascii?Q?126jI0K8XCsDWQwYhub7+ApmtM/BE0QLpOZIi8y+MV6wwGBPrx1vnkBLv73w?=
 =?us-ascii?Q?YbtHcmUEchFB+EU20KjDCaTkOqPPdFy27pUO55SUYzIm/klWblSGd6KiVifd?=
 =?us-ascii?Q?gcQTV8kmFBD3eVZvFCCMLVmq6AnxZsgeAOWn2v8ZBIGqmQL4/zhjQ21w9o7x?=
 =?us-ascii?Q?cvp26tDIiVtqiq+LWAbuSqky+JmAHEFwLY/fPB0p4a1LiZfCX4//CcnRzvY0?=
 =?us-ascii?Q?/nTm5DIrt+7da+hOmPv6KEfO/H882xDfRmc9GDRcPRQgZVljiPnLTe8ER62O?=
 =?us-ascii?Q?DrNKcQR8gSNzCQutpKOave54qJ+xReFszzpb8gVx3u1hDe/wwE6SQ/pfZs+w?=
 =?us-ascii?Q?2TLGWrxiPnIVT4CHHi6Lbhccbxp0ZtNmHWF79L//3zSDDR61FD+xgyt3LY95?=
 =?us-ascii?Q?b22gWI4UZmhG8t6U6S7q5Vw5SPN+KO70Yxf1/bPwMxDVIu6+fymm0yK49IMG?=
 =?us-ascii?Q?JiiivnmpHREzxiUSu0eC5CYIcZnwETKZlU4AZqeVU3zjRhUURsHvc+w/6QtI?=
 =?us-ascii?Q?pWUXd56XeX+J36K0EoxOuNGjB2ehFazqivP10ukoycUkZY0SDXEsDnuI5/cO?=
 =?us-ascii?Q?syXUq4R6Zi6XVkfeJe/A2adU09Ib9HXGBYqr2QM43DOo762VV0CnNyv7ktht?=
 =?us-ascii?Q?HPlhayUEtICZ+aM3XV4oxm54YgBYpYC7zIP3xnuPK51y5SEpT6MR8QOn2B4t?=
 =?us-ascii?Q?jvGKxcDZOA/XAqYFsrRyMvcbiLPksCInGhTpGtlFtXLyOWTkwsEgQjyo00GS?=
 =?us-ascii?Q?FBGkeTVySj2qntaAG+Ca3eBXQzxFLQ6gW7owp0JrhmyPBDzFKcqAhW0wzaG9?=
 =?us-ascii?Q?gautmMWqH1p1K9RQ1WsBANRK3+lkhI+zXRsX+a7zDbHHuCwgCygusqS/1My5?=
 =?us-ascii?Q?uTYYZmX5m/VIUpNLftKFNrNzbymaBwZs3RXKR/F8DR5wz0p/DYhZa3x702FC?=
 =?us-ascii?Q?COlVXJ4wjFJAgpa9kYZO6MtCQkRTqx3sIu36VuyhIHvVOCTcEt8kfN14Vhba?=
 =?us-ascii?Q?J+dE/iN9dq3iun3IT+0U5ieQg4gMsmd6spdP8u4eVb5SoOqbIiFs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 183226ac-5552-40e4-6169-08de58c8d516
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:41:12.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vz+4fD3WlvkNuJsjdCJ7ZuSWFMxB9tliwzXHH81R19T/FcC6HMwNrEFAVVL9vlteUWxnRcOn6rwIC7vj9Pnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6959
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8423-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CE4C153C91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:38:53AM +0900, Koichiro Den wrote:
> On Sun, Jan 18, 2026 at 12:05:47PM -0500, Frank Li wrote:
> > On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> > > A remote eDMA provider may need to expose the linked-list (LL) memory
> > > region that was configured by platform glue (typically at boot), so the
> > > peer (host) can map it and operate the remote view of the controller.
> > >
> > > Export dw_edma_chan_get_ll_region() to return the LL region associated
> > > with a given dma_chan.
> > 
> > This informaiton passed from dwc epc driver. Is it possible to get it from
> > EPC driver.
> 
> That makes sense, from an API cleanness perspective, thanks.
> I'll add a helper function dw_pcie_edma_get_ll_region() in
> drivers/pci/controller/dwc/pcie-designware.c, instead of the current
> dw_edma_chan_get_ll_region() in dw-edma-core.c.

Hi Frank,

I looked into exposing LL regions from the EPC driver side, but the key
issue is channel identification under possibly concurrent dmaengine users.
In practice, the only stable handle a consumer has is a pointer to struct
dma_chan, and the only reliable way to map that to the eDMA hardware
channel is via dw_edma_chan->id. I think an EPC-facing API would still need
that mapping in any case, so keeping the helper in dw-edma seems simpler
and more robust.
If you have another idea, I'd appreciate your insights.

Regards,
Koichiro

> 
> Thanks for the review,
> Koichiro
> 
> > 
> > Frank
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
> > >  include/linux/dma/edma.h           | 14 ++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
> > >
> > > +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> > > +			       struct dw_edma_region *region)
> > > +{
> > > +	struct dw_edma_chip *chip;
> > > +	struct dw_edma_chan *chan;
> > > +
> > > +	if (!dchan || !region || !dchan->device)
> > > +		return -ENODEV;
> > > +
> > > +	chan = dchan2dw_edma_chan(dchan);
> > > +	if (!chan)
> > > +		return -ENODEV;
> > > +
> > > +	chip = chan->dw->chip;
> > > +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +		return -EINVAL;
> > > +
> > > +	if (chan->dir == EDMA_DIR_WRITE)
> > > +		*region = chip->ll_region_wr[chan->id];
> > > +	else
> > > +		*region = chip->ll_region_rd[chan->id];
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> > > +
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 3c538246de07..c9ec426e27ec 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > >  int dw_edma_chan_register_notify(struct dma_chan *chan,
> > >  				 void (*cb)(struct dma_chan *chan, void *user),
> > >  				 void *user);
> > > +
> > > +/**
> > > + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> > > + * @chan: the target DMA channel
> > > + * @region: output parameter returning the corresponding LL region
> > > + */
> > > +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > +			       struct dw_edma_region *region);
> > >  #else
> > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > >  {
> > > @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
> > >  {
> > >  	return -ENODEV;
> > >  }
> > > +
> > > +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > +					     struct dw_edma_region *region)
> > > +{
> > > +	return -EINVAL;
> > > +}
> > >  #endif /* CONFIG_DW_EDMA */
> > >
> > >  struct pci_epc;
> > > --
> > > 2.51.0
> > >

