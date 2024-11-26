Return-Path: <dmaengine+bounces-3794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A809D8F5F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 01:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1611FB2400E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0B101DE;
	Tue, 26 Nov 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SMJMRKQa"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F32A47;
	Tue, 26 Nov 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579239; cv=fail; b=D448iS4STuGRFkuqX2mQPpWoW18LH9FacgvNiN6hxY697TRHKGWilAw7FhsVBb4UnnquyvWHJZD9/IsieMSCq6qyAtefK1emGDttWybpLd4ayRQQL/MvldzumGuTf/KTBYFW2cRREjciFmgRfunurMYqendGuz+fOzRWKb+sZD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579239; c=relaxed/simple;
	bh=lqywkHNc+mEvT/Hs558CPmejVd1acaZxaJk7bVhTOWg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=k8EPZWtkxGtwnykyho0HKYQVzkiG8BwSkoJS/DC3XtXzuHv3nxB/kbcJ3MgRnKzDo5kDhR3YxHiBSDheiIsMvjTKo7Fcjo6UgFLm1xEgtNkVvqDTL/Whr7nUCEriL7dtj7MKbpJngz3nOzGfaglk2mGhhdiNrJzh40hvxmHCNxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SMJMRKQa; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmNj6K08TQjvSXM1jaru2YBG/eYCDeRxJPfS5EUtsNyLOaWU7caFWqE3FhJZf4bk5Mi6kLfIudq9tMTemKV+ZxyaUZ9ImfPm7UWTHJCuMAJXnxfWHmIbqClSXm2KrYFTRNDu6IuWRr4kFi1Gd8bv1Gb9WXsU14BVZd+PW6Ey/ZMqS56tbcNMMTA9LP/+RBFHrIM3xTYqCvKBS7rt/s2M7XaQxoFb7I0pFffks3FFXRvJ/0PDQ04GkwMuEWj79JetmTivqAxSHLNp4yCGnLnFh/gaAyrLPKk+/AsauusLKjpa0rANzti1dL6eYIb2kKMjBphhP/SP/gPO242yuF6kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqywkHNc+mEvT/Hs558CPmejVd1acaZxaJk7bVhTOWg=;
 b=juijU3IlUATk0PaFX3tdAGhfsaQGDB+hoNDoCpOoOMovEqDIe78VILXq6Ddc2ttxTYD6rHCuqpupGXwVN9eBnGnedY3a5ST9YltZPIo5YYPRUrxFDvErMiJWJej2vMgROljvMrluZBVSdORxNjokGQBmUtU0AQ8k6v14EMqZJZCfg8X6XHihjYmBLj9rqZ7MOmdMlYxeJoQ7MJU+LIeC3T9fzLB+sHPtQU0zjEu4uRq81v7KXdu++I3akyyBR4X30hK1DWfLm8IEtAqQpYQNyZLP4S+gQ/mo5S6IifDnmZ5fFCeB1sdpbMwYCyNbIs+cAscqzubK8u6n/9Hrg2k2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqywkHNc+mEvT/Hs558CPmejVd1acaZxaJk7bVhTOWg=;
 b=SMJMRKQarqGDsUJ+UgtOLcz0gk76zPVyS2rUjvF4A0GT7/Hr7UyCjFC0vw1mNNsrKy6UnSTM7/dFnV7NJBizwBOjvSN5JLN12NGnx88FnLeHWSvnw1zM6RK0IB8ut4pLwUWY+xarWfPaiiU+xJth4TDx7bBSOKiQ/Z6cdgFIogg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS0PR01MB6482.jpnprd01.prod.outlook.com
 (2603:1096:604:e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 00:00:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 00:00:32 +0000
Message-ID: <87zflmsw2n.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: remove r8a779a0 settings
In-Reply-To: <CAMuHMdVyCNcdkE=HpRA1mOiE5qAF0+vcWbwJM531G91G-b9aTg@mail.gmail.com>
References: <87ttbw3zq7.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVyCNcdkE=HpRA1mOiE5qAF0+vcWbwJM531G91G-b9aTg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 26 Nov 2024 00:00:32 +0000
X-ClientProxiedBy: TYCPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:405:1::25) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS0PR01MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: f95a0c3c-1e3e-46fc-7a4e-08dd0dad589d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AUcX9BbWnYrqkk0LTKccG5MQnm6JF1RYOevtxp6V9oUAoXfPh6oSk/m95Y9K?=
 =?us-ascii?Q?DLCUbEoB7zd+t05NC0RLe4Qrnah4QObTW3n+s1anPA+HceAEgXLuRhRwP65f?=
 =?us-ascii?Q?zH0slVcWFDvAf4sxdtV8KcRkCn7WIKJQqHzsbcaBqJ25fS2C00BpxSS4dbnZ?=
 =?us-ascii?Q?2Dh+8uC8ked8BKFN4AflErET8hHVeUd5Ihig8dfj65TS8EMC5oDNcH3neXgC?=
 =?us-ascii?Q?Ql32e/EpJ7G0/nr69i/l/819ViKyuPxdwHHcWvSxws7usJfD52ho451gsfUx?=
 =?us-ascii?Q?9CfSDybi37vTxG86romhsBSUx/8LWeDgMwOODvK+KX87x3Rrv4vJm/hO/LZB?=
 =?us-ascii?Q?nBBFZwH5hV+hwLDT9acdlJfdcB5EL8U/G/CZZpL5rmYxH+9tBeIHUGDN/MQI?=
 =?us-ascii?Q?/VaEsoNUBKbd2kdK0lgnMMJXa+N9xgPMuC3SHIXO92EVTgvvmZNbE17a0Vy8?=
 =?us-ascii?Q?JuArz5zpCjrDqCdbSMTHWgIpaOzgsAWIRcU0FT7q0fFQsGVi8rbXJFUZ6Srv?=
 =?us-ascii?Q?cCGbCLXY5sadqIFYZbAnPUjxQGUAwZo/Aa5gNKRtSvqDTC2hGSXGAzOMXQQW?=
 =?us-ascii?Q?3OKRZKk5trerEEjV0NLyY/1eskFeFebCSUm6s4f5bFDF0fnypIuqkS+mON6O?=
 =?us-ascii?Q?7AdmLfSCFMQ6+1T1Mn5xKAwwMUyEMHjv5NIncdH3InzwqbCjP15lxltMe0lR?=
 =?us-ascii?Q?qIRbCFxwlHpcnydygrYxeg2ooFridAzUOCuWvugAWWJo2L9dExu723P9eJsJ?=
 =?us-ascii?Q?hpLlwDagLFmijhno9qMfOGm5h7HfeSl9v8N/KcP7m5WlRxHB5grqy6M0LT1Y?=
 =?us-ascii?Q?b6ZBvAZ2NLGkaYelwh4hrU3vA3O9W/PBY89i+1xQ/Ggfb5+SaSuOfIeWWKym?=
 =?us-ascii?Q?30nltHgaJNlJr/mWDm1uN/ZRyGwrC82VMwQucaJJm/ziDNN4ngqpAXp0ONPr?=
 =?us-ascii?Q?YtdjQxr4llOby6vGkm/aeH0ltrEUI+JHXCPyI4kYQVMZS3HsRoOrC3rzK2ry?=
 =?us-ascii?Q?NI29HWYiSFazKKpmfzZ43tVR/pZAAPVeAIzRZGRzU0FohpNaN6pRZHgAp5MJ?=
 =?us-ascii?Q?pqKV0UWCHNlV2pwMZFL/u1mLtXfmttxt8lem+txeim9OEZDHvlE6I7sAQrTo?=
 =?us-ascii?Q?on3rIlBioElwjxqopJyHPIfcxhO5XT/DTZ9nWCbUPjoYiuQDnddjBnoNx4Tk?=
 =?us-ascii?Q?9uJM6VCX+p28zps0yQK136cYXqyy/T2IhgERqodlahzwapgCz2382FCIWyWz?=
 =?us-ascii?Q?YcLZbDEggLmD4QH4zFCBiGnNl8hqjPsdckSb+mgUH330rhhngFWfqgsdQjmc?=
 =?us-ascii?Q?/9sjao3cRyW97PV6Ws7cBnfsWbUVUlkAZaKLjxX6IpA1bdwWdgpARUOS5iaL?=
 =?us-ascii?Q?kXaw3DAORNpQhbHPCLKHBir8mRQ3RZ24Gv8tYwbkbAvlm18cNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zGGR9nFK2ioq5CgZRNVxz9ScbXd3hTsfCvfh/til/kB/pPntUGVN0ZPsoQ2?=
 =?us-ascii?Q?d/0JARiV+N1/Qcihe3Hive/mWOwWOA1bH/dQ0CzmqzaHCMwl9zdXQXhZUd3a?=
 =?us-ascii?Q?ksViUDOVj/CH6BcR4zrYfAESKM7RVvtngv4kqguU17s2RGmWtR37sNlJiKv/?=
 =?us-ascii?Q?oiPrLrGICpSb6sioQhKaxoNcxyF6dG9OJBvE4ONKcVphUoI6LSIsNSxy30bQ?=
 =?us-ascii?Q?YWm+jkyouB5ugOD9XNo0SA7dNUR5Bv2iwEfgrYEjIUdSLn1aX2CHuEdrTINS?=
 =?us-ascii?Q?qRC1QWXxB/dtt1Rj3/ubHZTg0Z8cEprYRDIGAqGLTprfwlxMANDttLjlAEur?=
 =?us-ascii?Q?ewCq21hOk69GOmeey36kWq5W5SmpBdo/BQmhSzfFQqYVO1mG73fk1G106xt3?=
 =?us-ascii?Q?0p5gcc0OiGevDMHNMSdGJEuSxoMRwqb0a2lbikc96x1cjQYCDXRBP5q5Mj7a?=
 =?us-ascii?Q?PG+PTcN6GC2HdD+ilx3Hi5oIP/Ra2bqyXe/Y7v3PHUbgf/uTARD3tnsFdqC4?=
 =?us-ascii?Q?IDCV6e1Zp+ezK6k9lf7PHEP5eseEkFlY1yHd55Ke42IpQRFVCEZ1qTIAVwnQ?=
 =?us-ascii?Q?5IZZ3EcFH/ssil7IHFsblq3SmdYTHI3XzlMoCOJxmvJf/JYaMqe4wQQ1MFT1?=
 =?us-ascii?Q?u8JAijzbm3P5eKOQ1R1HnFReg/SlJAXZashINkUkM4EzNWXo+XmjFrHovE8J?=
 =?us-ascii?Q?GLO4AbWs3nXyA05R4TBwesoonumTMs2lS+guNQjd3aQgPR/eOP4BGVQv5B0T?=
 =?us-ascii?Q?aZxbQ3/uEEhd2Zyt83VAVaMhRIQQsVS3dLg7rWhVEr6dJKFqEQ6kovise46r?=
 =?us-ascii?Q?FPEd31QmtwhLnlyo7OwRQVGP+hbt2l3ONjLe64Zy4YGmlwrF7uxScofKRJNV?=
 =?us-ascii?Q?21MhnwMAz83SIT5le0zIU1kUnVQcNeih17Qj+W61kqNfOwBis3ePg+1d4E99?=
 =?us-ascii?Q?CsWpN3R+inqfDPJ+W7cU8OpnnjG6vMwo8G16owAAt0557lWLq11YLhL2ZFq2?=
 =?us-ascii?Q?F/f0MfoPreDTwzBkz/hVGzfmE8MRyKQ4zJwIWTuIZOM8SvbPtukLxQzOEfbD?=
 =?us-ascii?Q?Yr1ifssadSwify0SxR1ex6parH8A6CpopxBDy37kh2jyiQTpe48OPtoIyATD?=
 =?us-ascii?Q?cBh0xxfuHbTlhcUOW/d9s6l0uIWBCeMBHIzE7PhsUkt7eGTPWyEFNkdsVQck?=
 =?us-ascii?Q?Qrlj9LtQGDqukavMx/yb60EtonAwJCqltY7E5VVbbAKqRqheIFRdhTWbX+kK?=
 =?us-ascii?Q?9lW/ilznFq4KW1u9MJY37ci7JK5qG/3O/F8a7idT8ZYOZz57IAg8zjmjWvUb?=
 =?us-ascii?Q?NIQjKtSrqC0YQVRd/qJ2niUu31Lx7YGVvoUS3nnZTdGn6xrVcfHkilsTKy8e?=
 =?us-ascii?Q?veclbdWb0Dco6AuKyLznvZAJLK48XYxrmBcC6DuR27qURAeypT4MjsS0t49J?=
 =?us-ascii?Q?KEfzMI9D826qNx7EbsJnw7qxmhPX9sSztkC5STD2vEPNnKwXLlKvGHHX0sGu?=
 =?us-ascii?Q?gONCa62D1idRYFcp3RBKwQqN52tv5bnLMAgJgFkv9SASgTxdCxfu7l2CFHoQ?=
 =?us-ascii?Q?D9BOEPcGUL572TFqC15ElNUWMnXNQyVOxVayCzjyxAuggz5+5Y2R13+b44nv?=
 =?us-ascii?Q?l3Pm1JS2dZm6OquCwZsX6kc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95a0c3c-1e3e-46fc-7a4e-08dd0dad589d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 00:00:32.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ha8k4RdiM83khhn1wQPHk7/JKC7cjewIJNrkgbqM+thniTIiaKAQ25pv/gVGuOgXRB6AsPnIxRf3Kx1y0HCRU3lWx3PY0QGhz8oeQb7B0d0PDnuRLv+Vdn6og9ZSYA7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6482


Hi Geert

> This compatible value was retained in the driver because of DT
> backwards compatibility: DTBs created between v5.12 and v5.19 use only
> "renesas,dmac-r8a779a0".

Ah, OK.
But I want to know this info on driver. I will post v2 patch.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

