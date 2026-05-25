Return-Path: <dmaengine+bounces-10833-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBG6Fqr0E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10833-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:05:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCD5C6E01
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36B8030013B7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02FB3AA1A1;
	Mon, 25 May 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WgYCOZtO"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021122.outbound.protection.outlook.com [52.101.125.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F33A6B9A;
	Mon, 25 May 2026 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692708; cv=fail; b=C9mZMZDJrqGrdZL4YHmnJTm3mkl6avlntCVXhB/z/N+cRpsIudIjFO2RY7dhI8NcmAC9OlAlCZv5hWTPZLDLt2PFKyOH0vo2TYDk6kp4wjy/BYeKwfyzePf0QJVOZejCF56Aop7YCTzt8UU7l0+gdvpt8wtkHPY7ybs9kCahTyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692708; c=relaxed/simple;
	bh=4ZChobV6QLKe2gn+fpiQsdiFkuMKFA2+Eez0meoOf9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e3bBrBMik3ARuf+Bx5yllrztTu3PFSiGqo/eb96tI3dc1T/GzY7F9yWprJmSDxHoQW1LNSDfVmmSHj3jD0AOTbizPTcf8MqLINYq0LmyQCfzbIankP+RbBVtvl/NqOjxQ7e6TwP6xuQOKf9XlJN9f+Q6vJtQxEWCpX7zTSGQDIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WgYCOZtO; arc=fail smtp.client-ip=52.101.125.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVraw0G/3db0sCktpgS7JcIcR+1hlySwtfWVPTCi9Xtk/PCCndUwns958W+Mdkqynp9dvvJGbJXRIkcmUtLLTUt4z/lsGYKZBXHpnE1wFwJuRgt+jeyK4/ZkvOtu9/nu0q71UOcsDF5cdV+OwKYMgMO1JgYt06lTFUsd2+wNvdbaWoqwQSyeXq25x3VOGkYb8zy62nz7O+nhAb3EOUrec1rGBdJXFq7IppLDMFwGPUyIRCkGoku2Cqjb/KAuIt1v7agD2ohkbl5K6LiRkrirQVF57kqD7q+6JX/Lv7usVwJNhXh/NwgJToROiXvGftrGLGZrp9p+zNPoam3Fx6yf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BvjLrViAdZePStTW/99JMIlTSGA34ly30kBCZXaaSI=;
 b=QmgWnTpQlZGquB63FpqQXtO3UNooZT4IkoAh5fJtYPC68EuE2m16MH4HF5f37dcrv4jV48g3PHYauKnGFWixZr4tTv8LULZfMiUHRSo9buydmqUMQrJFfmqzyOUraoT+X93IOKZVMC+D0KlQiCeoORMRi2fW6XP4ZfdyM7MUbNPOWhLoY3G2j90w+cB09X+p9eQAL1MwoRlzoY8Xe7hzGOgesYqo/IqviCfNzYWQNNEQ5ZES00eGYHnxhwUKCYsN0iWXUFIx2OGlmYVD3/EjSJuxm2I3IUm+BEPYzCFb67BepA/lFZKV8hlOrR2Lw6cGho5wYyKN+lNpHFG5pkN3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BvjLrViAdZePStTW/99JMIlTSGA34ly30kBCZXaaSI=;
 b=WgYCOZtOPjsTonW3Hu6p7iUW3UOegxWZWN6WOwfLRWUyJq9pavFGtzhD5BbJUCZoQ2iDxVI7vVQPKkQ2SOpeZNgtcvnsR76/3Br660Ayd6h+UXnoEA0ssoUbQH4p9n1TN22CTFlz7B6xcqAEYUKDNu/Ad016ZuvkgKMtzmu5oB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5346.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:267::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 07:05:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 07:05:03 +0000
Date: Mon, 25 May 2026 16:05:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
References: <20260525063456.3317509-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525063456.3317509-1-den@valinux.co.jp>
X-ClientProxiedBy: TY6P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 479d5542-b5aa-4b4b-ff14-08deba2bf1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|56012099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	rExSbDnb4P6em1YN0BQy9baYphmPW0hu9qfILwUj56hVQmn8+wAtCo6nM6Dx8mrb/wJeX/VFH4FQbZRNcs+INp+cVq0O2xNTs4ArSHUsc7glT4RyQ+qcd8A3c1ksZxbKgL/Ar/OOj2DGQPwURl8ABfOcp+NQ8nfGln5pOQSNCR7zCwPVS9sRsJTrBCc9Av848wCtjsDgb3arGEhJZ/ZsmoTEfU0EfuXu9xzebbFWSfQwWiy5bXCbEVdS8ynJ6MlyuSAA6VCHqhEaC/JJc5clrxC5Yh0gvy1cH+lJ6e+cZCz41OR0An1wqDOU4mCW6v5TD+fleAJu2WqCMAHLQszsiHtaRvRWQ8uJyVn/aBKq+EHimAFSEHEe5/pGxuQeAWHQqqA3Io3AjyIFPYa0cLHzPh0zW1Y4XMW1DYHkWro3jmbMpj1YdgljaKVHuLRIf/XX6Z6XrQWDfdsmAm6vmffp03BVFfYXfyq1gT4kxFt3+sfe5AUxk8JVsmGMupmFatIlo29/Xb+JqH4slJgc+UjOfCWgEdC79FYzBUc+us0yHjWn4JPATxxnapdyIMc+SK0geSrL/kLvPkIcJrdaVkcJmE9Oesv3VKFbIYJNSZBrjqpy6FFT3JD8FmBRm1RLJIgD2CK191z5hbQZK/OrJgOa0FhOYA4945gGfQZ3/N94SIZ6QexJfHwSWrKNL84iQLcpFHmZeYFYI1mlVmU8otgXHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(56012099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LheMNcqOs8jdFmmpUa4XmdBbh5fGRtzcfnKATAiMNu4UeK77Rnk0l1FrFnHc?=
 =?us-ascii?Q?goKcYadNoMeUGCDlx0PWu1eK6xCBAQCl6xhUfQdcxYUZJAqpL5IXsX0Ft3Kb?=
 =?us-ascii?Q?CtMNuvU5sB2kA52PlLLkH9lkjRN9GSPN/A6bn1A32udA+0JErAfARDF+2cDs?=
 =?us-ascii?Q?3fnM0S6RmvyIZjC740RxlyJlyTWrxKSpcHuylEYoJiXv9/90q13QeiYWKcmD?=
 =?us-ascii?Q?wJzxW3PFDp5ytfRnEpo9I+Dn4z8ohudBUQosDncunC9iVNaf6t/FjoEC0PZx?=
 =?us-ascii?Q?0fVDfy/ZX3gcoVr7RAC7ehehNDWn9lxTNu0cgWL4QkJffb7iJK9+THeJnchZ?=
 =?us-ascii?Q?cPAyiANcvW1qBngLguzeUkyyInCwkWnrpIJUsTQSMEVzHpQ+dW6eUQNStf1F?=
 =?us-ascii?Q?Kszob58SzAVUEeU9encGDGOC1AWsuffOqWBorSnC+SD064xz6V5o/vlV8jYR?=
 =?us-ascii?Q?BvNJduTmf6IFa8xaZibs3H5N5+UUtgl2RzJd1utGZJYs/4PbaYPZAPHiOwwQ?=
 =?us-ascii?Q?lCyG2jljCHXDM4A97Hu4bFGCd3PKFLakUYeZNbS69vHfKz7R+NNpyft+DQQ9?=
 =?us-ascii?Q?QWvLqAKRRw0sVcWpQAtr1d5Up4lWtIAc+FpOBg2/soiw7UIDiVa7NuuLjrN/?=
 =?us-ascii?Q?ZUJ+BsQn6Omwh0OP8A8Evgzs36o7Og+QVEq8mDo8ZtY51tN+0FLE0SFJGZlV?=
 =?us-ascii?Q?/g38n5CjQVDFYTV9/D1exQJkvQZA1aRFtIw7GenorJd4kQaatBCi/kyTXQt8?=
 =?us-ascii?Q?25kl9neUsKsbt8IfFZzffjHHdt9V2GiDflv1v+ULPOJtnXbqZFDdhvMft4OH?=
 =?us-ascii?Q?wNZgfqS2WyG+OpFs0KoenhCvhv4BM9xXm993vDAbrqTH79/AcDfdAlXSINo7?=
 =?us-ascii?Q?rijXBWTEDELrHwo40GUquAUyfrKp7g3qT8zinVFQXktAtcUZwF0C5ZZnnWUF?=
 =?us-ascii?Q?T/9y8txV53yNA8gSJ5sPmY/JJ/F9wFkectaQYXjCCpaf4f7SYKSTeHs39D15?=
 =?us-ascii?Q?VXHNMhJAUXC97Uw4V0JcQOuO/0DJR2EMM2/X456l+RIZ9+87kpS7RkOaO0q6?=
 =?us-ascii?Q?WFdY+fpOWxcnRjTPvEi9LWkocomc1WHd5CZraU6XW1KQ7gj7cCyXvwlHsr/N?=
 =?us-ascii?Q?Grod7MuiOXKvnPuDbkLnEJvA0J4lAA7hSWNFMdALf3/O4WniiPCLOLTi2kzE?=
 =?us-ascii?Q?8KgifHwbSwdC3XcX9lroBMSvZb/gdXR17hcwLAiY39sWeewgl9Npq7B2SZd3?=
 =?us-ascii?Q?QILlYhAY73YHmCMyNb2JxhbJC1kR0I+7gS+lFDHDCrqexp14Qq82Iszpjk8y?=
 =?us-ascii?Q?tcfydEgMdxe10hQ1fi+6uq2Y5I06c1FTJLEjMwrjsO/GOZpJ61lFHL2mSSS6?=
 =?us-ascii?Q?VaJmOv574UV2etX/guXZJ/tJfsQ5UqMAJQqsKxXjPXMPB3kVcA9J22wRm51e?=
 =?us-ascii?Q?hZ5B/Aw6MgVqrzYHrtAJ33GhogLw3bUP6JtYLgJIrjneOMwxP9yheIC2wcrb?=
 =?us-ascii?Q?NQFrWUq7HO3ArIlfVNPtkCH/9tQt7sxppdfTMJ7uzWFjPLo5nHkOMqJ3WwZi?=
 =?us-ascii?Q?P3rQAm5UD4qoAcZMuax+uctBI1ZC6i5YGdwqCZqrH0/+4O1T9o+v1XBbbbnJ?=
 =?us-ascii?Q?lzJEwbx+Zn3zX4jBqimzBOxj2z6oQgxvp4GkmIq+za5b1f+OvcNZCe+7mCA0?=
 =?us-ascii?Q?eVZhiORj+cov4g63T+NnmL1rgD3IVaZE1hBDQEAY+ONbQnu6n1GiLaNQRehY?=
 =?us-ascii?Q?jN+1tENYyyrHs/Z16UtMmU/vdR11el3R8pE7wP/a8DPBd9TKSBkG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d5542-b5aa-4b4b-ff14-08deba2bf1de
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:05:03.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtbQjoN7DsKu7iyw8NlyYy37U52dXHsc+Qt7CWv3RIY9fS6IpqKimBLOvTT6cy8uy0BPxaiD4vXc9sTvriiIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5346
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10833-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 3CFCD5C6E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 03:34:53PM +0900, Koichiro Den wrote:
> Hi,
> 
> This is v2, part 3 of three series for PCI endpoint DMA.
> 
> The three series are:
> 
>   * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
>   * part 2: PCI: endpoint: Expose endpoint DMA resources
>   * part 3: PCI: endpoint: Add PCI DMA endpoint function
> 
> This series adds the host-side metadata parser, the pci-epf-dma endpoint
> function driver, and documentation.
> 
> The endpoint function exposes selected endpoint-integrated DMA channels as
> a separate PCI DMA controller function. The host-side dw-edma-pcie driver
> discovers the BAR metadata, requests the final layout, and registers the
> exposed channels with DMAengine. Host clients then submit transfers through
> the regular DMAengine API. The endpoint function keeps the metadata BAR
> stable and uses a separate DMA window BAR for resources that need dynamic
> subrange mappings.
> 
> No fixed PCI ID is assigned by this series. Users provide the PCI
> vendor/device ID through configfs and bind dw-edma-pcie explicitly, for
> example with driver_override.
> 
> 
> Dependencies
> ============
> 
> This series depends on parts 1 and 2, applied on top of pci/endpoint:
> 
>   [PATCH v2 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
>   https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/
> 
>   [PATCH v2 0/3] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
>   https://lore.kernel.org/linux-pci/20260525063129.3316894-1-den@valinux.co.jp/
> 
> 
> Note
> ====
> 
> This series touches both dmaengine and PCI endpoint code. I kept the
> dw-edma-pcie metadata parser together with the endpoint function so the
> metadata producer and consumer can be reviewed in one place.
> 
> If the general direction looks acceptable, the dw-edma-pcie patch may need
> a dmaengine Ack if this series is routed through the PCI endpoint tree.
> 
> 
> Tested on
> =========
> 
> The RC-to-EP data path was tested with a small out-of-tree DMAengine
> client. The host submits a DMA_MEM_TO_DEV transfer through dw-edma-pcie,
> which uses a DesignWare eDMA read channel to copy host memory into
> endpoint memory.
> 
> Tested with:
> 
>   * R-Car S4 as endpoint and R-Car S4 as root complex
>   * RK3588 as endpoint and CD8180 as root complex
> 
> 
> ---
> Changelog
> =========
> 
> Changes in v2:
>   - Follow the part 1/3 and part 2/3 v2 channel-claim model: pci-epf-dma
>     now claims delegated channels through DMAengine filter information from
>     EPC auxiliary resources.
>   - Select raw-address dw-edma-pcie platform ops from the endpoint DMA
>     match entry instead of using a match flag.
> 
> v1: https://lore.kernel.org/linux-pci/20260521063638.2843021-1-den@valinux.co.jp/
> 
> 
> Best regards,
> Koichiro

Hi Mani,

I would like to ask you for your high-level opinion on the direction of this
series.

Previously, I have tried two different approaches for the same objective:
avoiding the extra CPU memcpy (or local DMA memcpy) in NTB transport on both EP
and RC sides.

1. Put dw-edma-specific handling under drivers/ntb/hw and let the (new) NTB
   driver carry the metadata needed for channel delegation.

   [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
   https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/

2. Treat endpoint DMA as a first-class part of vNTB. The RC-side ntb_hw_epf
   would create an auxiliary device, and a new dw-edma-aux driver would create
   the delegated DMA channels on the RC side.

   [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
   https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/

   I added an ASCII diagram for the overview as a follow-up comment here:
   https://lore.kernel.org/all/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/)

Now, this v2 series takes a third direction. It moves the DMA controller out of
vNTB/NTB-specific ABI and exposes it as a separate PCI endpoint DMA function.
The host then discovers it as a DMA controller function. The initial host-side
driver is the existing dw-edma-pcie driver, and dw-edma-aux is no longer needed.

My current thinking is that this is the cleanest among the previous attempts.
But this is mostly an architecture question, so I would like to know whether
this direction looks acceptable to you.

In short, do you agree with the direction of this series, that endpoint DMA
channel delegation should be modeled as a separate PCI endpoint DMA function?

If you think the vNTB-integrated direction is preferable, or if this should be
modeled differently in the endpoint framework, I would rather adjust the
direction as early as possible, before building the NTB transport on top of it.

Best regards,
Koichiro

> 
> 
> Koichiro Den (3):
>   dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
>   PCI: endpoint: Add DMA endpoint function
>   Documentation: PCI: Add PCI DMA endpoint function documentation
> 
>  Documentation/PCI/endpoint/index.rst          |    2 +
>  .../PCI/endpoint/pci-dma-function.rst         |  182 +++
>  Documentation/PCI/endpoint/pci-dma-howto.rst  |  200 +++
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  374 ++++-
>  drivers/pci/endpoint/functions/Kconfig        |   14 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-dma.c  | 1366 +++++++++++++++++
>  7 files changed, 2138 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c
> 
> -- 
> 2.51.0
> 

