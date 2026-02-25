Return-Path: <dmaengine+bounces-9052-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHPyESaynmlxWwQAu9opvQ
	(envelope-from <dmaengine+bounces-9052-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 09:26:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F71942BE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 09:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 612B03009F25
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA01E98E3;
	Wed, 25 Feb 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JaxWuiH3"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020109.outbound.protection.outlook.com [52.101.229.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE982BAF7;
	Wed, 25 Feb 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007969; cv=fail; b=gN5lGvWX4ZuXFwVzJnf79BctqTuVSmpI/kMEhDeABnN5VveG8/d/K9Y+lVYE+p4rEOAfjAPLzXlJOkipsrcAFt8A0cH2RCitCPUvjQJ7FLmBjwtPhdKymbF3hMMdQDOYLfTTMI9IQtHq2Y6upPwFU3T65ZnFtCJD1wwmPs9Zytc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007969; c=relaxed/simple;
	bh=Pl6tjsbRsQbcjK9D2qlpZdFQW7eZH7zvGggCtn/5tPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gEtmfghlWL5yWoM34ojP9XashwMuxvF/4IW4u1DFd9+C9/jlYcd+c5wpmfPHHYzKjKBXufjWxLzXpWT7Mfpvlzo5V+sjjxV0CSovJG9CO0KsA8Q3qw88FwkqsisIRMoK1LplWn/YPdIq0Zl4ZK3Z48ErLMYdSp3AlXyjBPQf5sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JaxWuiH3; arc=fail smtp.client-ip=52.101.229.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI3iXJgoc1m628xxhfwlDiF8woC+jfvD3aBQ/Hiy4+DvPJpZIHuNFnNa8gjgZT57WKUx9qTbCBVKbx3Sqjmeo2C58R2JaGzgD7v0AaCWFzNdaDqA8ve8LEoMQTcTBlYxv+lrtlEGWY4FPBoFQs+X5qgKenLr7WnKeL4mlaTLnL084Aa191pJcHYlQMLYQIU9UA3Ize0shplpcVyot2KJbrPIRk61HLbbkQKTlFf7NUrSGk7Bdg+pKKSOUgVu0kHUHUHsH5t9BabJx76Mtaj0ljanGd+lZoOAcev5pFiOF1Vw3sdag4HHw6BVzR+Xz6Edwd9Z2DZocZlZvAcA2gXD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGduqUr7kos/2KaqUjyU01gGePXmBmLdQaEyH5RSqAM=;
 b=c9TCzVE0OYTyEXTk199JlIBaqHa+gfIc++kvxF8GsdKSUYGCCZZyu4W1uiTBpw9RFVy0AtoQQ3VV4Y2rqM9lO2p3ZnyRL4jGP+6u66f6eJcaH4+p+rMsQJAYCadSd0uIpRGJbkCmJK8JZs1z7UFydMcJ7O/gMXlbUo3H0GTGrGplFeeUl93Mor5k7Lw+kA7EacYsbzf9PQdEon491xPDJ/NkZVZ5HlsRqnrEAtDTICXydCXPU1xvoqfZSxOlYSF+P/6n+/PnuJzTiIHTWWZ1hP1iTmieMkrl5ziN93sdfPo1iZoOeLARflatZTxilhZVVzdcdh0hmP3YLZ9AAEdZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGduqUr7kos/2KaqUjyU01gGePXmBmLdQaEyH5RSqAM=;
 b=JaxWuiH3C0JvGMHYF19g0pim+yHltKGtEs5tmGiMngQ3txxZSvxZUpP07tr+xm4lhWdT8q5CqPyY3Fb/XjHyo4lDg3m2Jeyp++0sWtxr6dd8+yIpUf4ih6bh7Ly3c7tgJ4JQOiux8YReOgetPzEiFblMRnOk4YOIrAedtJcGQNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2628.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:26:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:26:03 +0000
Date: Wed, 25 Feb 2026 17:26:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
X-ClientProxiedBy: TY4P301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c96d607-a926-4c58-7631-08de7447837e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHboryX6Lv8cm7kxKmuVCqCCmg5aaPcqh2Z2d2j2E5wIXRMdKLqDggvk9hCq?=
 =?us-ascii?Q?2gOcx3hrrC2oYh+IELc8qFMaSqISB/bIWmqWLg2vQ/YrfJU2LsFGM6dKY8m3?=
 =?us-ascii?Q?zd2hRey5nxtxXSe3SFn7CFp2TtRfnMenrSDCy5Fm/S9TDbCH0ftFyqyOcnAe?=
 =?us-ascii?Q?tQRf3ivyE2dv5YZgpuK1nev/0hC+HH0K759GESAa9cFpX0IaJO0NygrJAGwo?=
 =?us-ascii?Q?KU255p8XkC1g6j0GL8ctdzs3JshofVG5HrpnaCh/jxgpFiWTXRVL9CgyAYCX?=
 =?us-ascii?Q?/A/8QAVFp6nbaZDlOchqWWM8ZZ/OaOVMJ/35KoC0XAHbvKcBFHcoaAFwamOl?=
 =?us-ascii?Q?9WB9RkDJDVPNM53XvptxCaH1+g+125DYgNKiXyUNJh9F36ssCI+T48VCnuhJ?=
 =?us-ascii?Q?DcgIfKrN6qH/cTxYFZw3SUABlyW27b2CV6M08bOjbP7WumuqlsIXsqs7WsGs?=
 =?us-ascii?Q?RBK4koDSAPLjgJcaNbEmbi9ikidOuDkhnepBa9NmeT8SSef2eJpCIVdyOTdJ?=
 =?us-ascii?Q?ePwIC2q27/XfvwBI1/DPbhzetRRGe4NjkkQcwZFqTA8bYv4FTJZ/VEgxSZ+w?=
 =?us-ascii?Q?j151YHmCQu6aFX4wliR8IrWMGRagcslIgL/zIPmuEOvN+iZhCT5TJ6AnlPat?=
 =?us-ascii?Q?FHKy2jgVKKuT/SGx8jj6kcS5vyyLEyM2XW1MLn3q0NrMDwy4AsN/5OHx/EdG?=
 =?us-ascii?Q?13bYjBt4QbsuEspUuub+BtUy2hNcZsIb2k0ox3gXJAciNTX4ccrh1TZf9bXT?=
 =?us-ascii?Q?Dc8bjE9uEvAeCL6mMPS3r/ndu6chqXSbCc4uRSBAh9ST7FbNkGxL7RROo9oC?=
 =?us-ascii?Q?D0tlKs01tLSdX5TBa20ArmJGZhjlSu4l37bRy27aWBQP/oawm2ErU3c8fU5u?=
 =?us-ascii?Q?EFmQlmK63K2TkPv0cD+QXCKglr8gKXaQCuCD58pCsJKFqj0PM8mvVqg3JCVE?=
 =?us-ascii?Q?cAZTSKqWvmcqn6C0TG+iMrTKgrYBZmKuVf1+dmaWmfTXU5qb+DeyY8mdMuXf?=
 =?us-ascii?Q?heyzhgrJAQnnBnnCrropMu8WQeP67gvaLsywBDG3jo3eHKIp6y5m65eeG6L/?=
 =?us-ascii?Q?2DVUI2gAVw1+PzrilUEAUU7ZW6eR6cq4wcmK+MEahReYGQt2jLRQgNp4+jNp?=
 =?us-ascii?Q?g+OMcKFl3lZzVFvOQDsJgeWG7raiL9S4H9n4VGKZOmBIqfUif+iEN67wpJ/e?=
 =?us-ascii?Q?CNPT0cm/L82odsc0fTMcjV7R3Xy8u5OjvFKEHsMN4lSfqmDanRKC2rvzvAni?=
 =?us-ascii?Q?mAO7drRaPUhmHm3+xiVO9lS0GL9oyrQlspl6D68pyDUihw239/tLpj6mZzMq?=
 =?us-ascii?Q?vq4Ft0Cz6rPl22RnbPdz8iAcDW58EtpzVxEheuvyJ77ZssuYfYlMIuUtbDDQ?=
 =?us-ascii?Q?VkRONaS55x3n32CV9DDCIPgOlW45i5KEi6SXmiwhyXrpNDwlu4bQBeBGpjy5?=
 =?us-ascii?Q?Y8xsbh+HOeWG8NsFgYzF/ekt/V/N7sX1K2i91fhJSLfumQTUCqltiZqtqnPs?=
 =?us-ascii?Q?3BpRa1z90DrgFiEef6I8QMeZF+uFgLCazBvz1ISsaArnzPsVOoyMAhKRlTgM?=
 =?us-ascii?Q?G/5YIJb/C33FPFPfKM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U0fSEPbf204d7kzHMMIhuwoC8JiM96tQVbvMl6mHnM29KUTD1J52J+v8R5Jh?=
 =?us-ascii?Q?ySfox6vQnFAdpwn94d7v+MqfZC0mURVOJiKUXA85VNE020PdaQNvpy5zaGPH?=
 =?us-ascii?Q?WLrGkZB6ht6az3TnZqLFybREOJk3JoL7LVLOOOgV/Po7d94PGi1z51M18pMp?=
 =?us-ascii?Q?sereBbbM+Dtqsww2RTfjHQkKh5xhewKHxfZh9EmZ6/U1bIEnFuBrj7gsL+GU?=
 =?us-ascii?Q?lY/NAUDYLov5vJl2yoh6HPofF/NAMf0ll8saAXXMdcBnZ7CMQ8MEh/Nffk9S?=
 =?us-ascii?Q?YiYt8Pw5ZI+s57G1EIk11/YE7F+cQEZWp4ANwyG/Fz3q8o844/jiLWxTaV8s?=
 =?us-ascii?Q?CxCtP/SHe44pY7p+GUS1iaghAw0OmOFH2wPJjwlJmSIYqcQtcvrtoojiP/n4?=
 =?us-ascii?Q?mOf7GCNqVQR6tK97+EWD+o/1y5HmFCxAGa0WC7M50DP5NACIuUaS1Tf4U548?=
 =?us-ascii?Q?Yp7bnL8hIMdzkKPjdG5xom1HVFv2T4ir61H0zjhdwDOP71MM5td6Pxr0usUO?=
 =?us-ascii?Q?Mf4dkryl0NdAZiOdotp2SK1gv2/mzsLiKGBRRuAc38nHKspA3adKJv7MTZNu?=
 =?us-ascii?Q?0gt2ToEVCFcwlOlOkQ6EgB26TgGocSlVrWUQos8Ta/bmFSnlTkgoyNX/Bl5G?=
 =?us-ascii?Q?sf/zm6nD09x1/nOUQtwwj+WW+2gOOQOt/+BxeQ113uVrtUlLYielncJnASwx?=
 =?us-ascii?Q?FGTuMbkJTJ/gRhKsgqadJu7vuVQa9QZScVlqTl9l2qYS2WqSPxR1ZVCmnLfW?=
 =?us-ascii?Q?P8x7sXYIuaCp9SO/zeD/CuI781QwDMbjSPuNJSiF6k8aCJoC+P2A5fhgcg44?=
 =?us-ascii?Q?7ZoeNjO8D2LK7b5Kl6d5QwNMdKO8jZecI3IKeLM1DBEiFr+ZHq0S/1zYdb5T?=
 =?us-ascii?Q?Wd14NG55bDROFNVK8FBeutfOentw3QQY0ZoB1dndri2Xybvdqst5Y2HrA0rd?=
 =?us-ascii?Q?Crj12Bxsgb/ce+peeHTCR9uZ1TajgKY/cyDblh84a2jraRp35d0Opd4tU6mG?=
 =?us-ascii?Q?ljw6JpadJa8SIdciFzh/o+6uon980PmXKc/qkHoA6ts/C8rnZRceoj4/hneI?=
 =?us-ascii?Q?Y/ZztAHFkd39uOU7YxX4NpoWLkiXeb63mFWdVhQmenoJp0n0WMe7e8S9po8u?=
 =?us-ascii?Q?FvZIHx0CecUazLKbKQPYZMj1JzpMZK6JRkFqWVTLbHvUSRbbp+RiVodWyavW?=
 =?us-ascii?Q?eUsxVfaowB20KqOaXwyQmwC/Xv6GrIn86lwZd3bfL5KNCRnDPEzOt1XWAW6y?=
 =?us-ascii?Q?tcY1xJumJmmFhTWS51DVRx2XvwedxRl9BZ8cfV25xPP4zIZM0iSyRWE/HLH2?=
 =?us-ascii?Q?wShUwnL2pD8FG27XMuaMnW1U9kC/csjc8ts/dMmua46mV95d3XEMeHBTv3lN?=
 =?us-ascii?Q?Q0u3R1VoG2w0PH5NrQad/OWswBWbnC1WK5KLzGqj/RMKLcM20ym8f3ITuWBa?=
 =?us-ascii?Q?FGpKbH9gRlPmDsBiBOAKuRNrMcJD/O558QiFbwkuhN3fQSwrFhykYQFP8muo?=
 =?us-ascii?Q?2U+n4h2B9Der4i0kZBqEg+5QNPewQKD6mQ2wZ0kNRsdZGWD6ASfZqJg8PXX+?=
 =?us-ascii?Q?oX6v5amrNFg71RScg0d/S9ytU+pzaoBWhCk00A3tgxhHX1s0eYkdXaoG75VW?=
 =?us-ascii?Q?XLEziwxqQXa3LjptEkMuMNoVxuIV8QLy2PyT71jCionIRZ3D7PbGfAWj3fKi?=
 =?us-ascii?Q?AC/ALL/hROS8T2QmK4tkVYHJS7gTn0W2xWcFee0WvwykXyM/BPXxQ03MW68/?=
 =?us-ascii?Q?eWnrhWYgaTG6F1x6XBm39A+S3a2E2TxsXiXr+KCOQDOmjGXMGygN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c96d607-a926-4c58-7631-08de7447837e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:26:03.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxHtAHYQ03OQ7VmKCn/cm5U8/UIizhIB/sPhUYW1KVu2IoKqmdcxh6szORMU7lir7+o+zP26GlbNVerG7o6U8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9052-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: C40F71942BE
X-Rspamd-Action: no action

On Fri, Jan 09, 2026 at 10:28:21AM -0500, Frank Li wrote:
> The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> channels, and modifying them requires a read-modify-write sequence.
> Because this operation is not atomic, concurrent calls to
> dw_edma_v0_core_start() can introduce race conditions if two channels
> update these registers simultaneously.
> 
> Add a spinlock to serialize access to these registers and prevent race
> conditions.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> vc.lock protect should be another problem. This one just fix register
> access for difference DMA channel.
> 
> Other improve defer to dynamtic append descriptor works later.
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Hi Frank,

I'm very interested in seeing the work toward the "dynamic append" series land,
but in my opinion this one can be submitted independently.

Even in the current mainline, under concurrent multi-channel load, this race can
already be triggered.

Also, with this patch, dw->lock is no longer "Only for legacy", so we should
probably update the comment in dw-edma-core.h.

Best regards,
Koichiro

> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> +	unsigned long flags;
>  	u32 tmp;
>  
>  	dw_edma_v0_core_write_chunk(chunk);
> @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			}
>  		}
>  		/* Interrupt unmask - done, abort */
> +		raw_spin_lock_irqsave(&dw->lock, flags);
> +
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
>  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
>  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
>  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +
> +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> +
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> 
> -- 
> 2.34.1
> 

