Return-Path: <dmaengine+bounces-10888-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMS9Hu4CFWroSAcAu9opvQ
	(envelope-from <dmaengine+bounces-10888-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 04:18:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D25035CFC97
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 04:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC7030071CC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A412281532;
	Tue, 26 May 2026 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ovwGBpsc"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020084.outbound.protection.outlook.com [52.101.228.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE632EDD78;
	Tue, 26 May 2026 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761900; cv=fail; b=j47p2/gQ7eW7bdUkmedavlgfmppMaCLEIUp/HVeu0LyzVBr+hi/7AD4N2FHBQuLI4z36bpnPrJxZlLfV4cWh8Sr/X3YWwGuadbCvEO/Cw6hk+8tpmhGG+xGblN+fd/QQRhPrjNB5RfwYLpEx3KRi4SGh4Pd+7zeCbNcoZrofIEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761900; c=relaxed/simple;
	bh=1U/5QMamJOeSnKSrKYTXACs3+v2E29ODzojQxLQ1cDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7O5ta2H6alXZ7Bc0KrrN/ZXziGiRH5Y5tcF3JuSRDrLYKRemJNiXdLByeKh99v/DWMiASdFWrttZKCz/Z5vZ3sFDNAsAZxp3UPZbIark/1YJO4tq5B+op+H5VRU8lA3/3iYG22bKNTzKDcWACrMe6e7QCJyf2MyXseJrI03ZdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ovwGBpsc; arc=fail smtp.client-ip=52.101.228.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSRpq+hrcoTFECCPYXmCbRWFPNvDXnUxgJEwzg8epLagiHjo0ov02Yswht45wF9ILlQMGyBBIqFoSFfXik360nVUDkD090pLe1FsU9gFvU5jqmxgTSReqn3X+BrezmFSJ8QZ2w+K0YjQPaeh50t9ZrBtKmTKO1M6bTsk/Fvo5NVAIgtFup4nPUVDCt23iC9c4gDLB1wIJ+n9LxI+bk9BL81WdOFabpmkOLdinpYASlQG4FRro2xF8dsdp/UZ30pyfSd9SUd3EhTsElt36zbuVyU73fjIYULrn56YYDJXcAH2ptUBNKgjAlo8t64MyfIrcDNJ1W1dpzL3snc5ANYO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO0pxqUUX+ywJ1iUvEyw/zdIm9Nx38l/Dr18wP3WWvo=;
 b=Kll0P3Yvik16ve8T8QuMwlybkpwBB7ahw/WtDS6NfjqpE11oXlKCK9KGrB34xd4165OodjqcWibosVdGu3f1BF9VJ9xzf1bfGvRRfjLhVlj99sv5sso1VmVxUoL7aft3/hStkyaYchZIvpR3nKllv3kFxU85hdIaVxplpZQUBPKgVQToaCvQqMuotM9qw/JBO3GS3/44MkbeG1s59csb5R/x+bFfwlZGJOKuuV7ZwJi+94jJ8g8citJGXySSnmAC3q3o/HEllEgZIBRptZmCHp9/gEEHTqzyuavFn6A93RwhcQgqe/oCSuXG/OXnTvj2/ONHt79nV9mzQsD0lRy6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO0pxqUUX+ywJ1iUvEyw/zdIm9Nx38l/Dr18wP3WWvo=;
 b=ovwGBpscWvZvjdkihzxvlAJt85rTxcFJlXCUSIBYhiRY3HmXolmUx5QRKEy9vDrszEOFZ/BkBr5nXrlFO1myY9lqha9xEUYYQLESMz9Iygdd3bwqvqJtJ/sIU4MmD9wN7dPjxYjI/Bf8SI+oGadmAWgE4A1ZYv/2XROmc1XEB2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYVP286MB3700.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:18:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:18:13 +0000
Date: Tue, 26 May 2026 11:18:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: PCI: Add PCI DMA endpoint function
 documentation
Message-ID: <qloowdwdegwjzhmkpxzuyyrnwa5woxh36qjx52yzf737q3l2km@ot763micqegb>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <20260525063456.3317509-4-den@valinux.co.jp>
 <98d30903-e456-4cb6-adaa-35b98ee7008b@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d30903-e456-4cb6-adaa-35b98ee7008b@infradead.org>
X-ClientProxiedBy: TY4P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYVP286MB3700:EE_
X-MS-Office365-Filtering-Correlation-Id: 223d9a2c-db00-43cf-bd0d-08debacd0a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|5023799004|6133799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nivh5b0lLc2z4+m+3shrhgIdj5cqmaRnFn0jBa7mwdNgtuexmGtsJUfLCkoio1aHQ0LxLjvnOS/hOeBucVRu60Zilksl8aUdnbOr6G1ciUotxISfpsAzrfaC2U8qGNXqdybU2efGWs6mTPd8FXE38qeJpAj5HBSWs3qc3KGZqO8vVA5ixvUbx2t+V+sDrlGYbqnLCQJKwhNilGmVr4zVb3x8BmNJ3gjeJqC0KeSlEINB9iedmFcvZ8Ulq+xpvOx9oB9/TwLQo4xd7kV+LnUa8Pkk2LuxfQkKLR90hrA9GJWaXgwd63mFBjYhq6dp7gE0MsczwlUaUbtESiK9cP6gYP0E9f49oqGnEzhheqYOq1D6ogxyEUrDFC8WSlvCpzv68B9Wml0RRDgNt/eg8FeyCYrfpnzvbshVNatGsRHNFORXhlf7UmUInykBkNHO6kSLo7wIV+MnNYORVJbeggijQQBSEYghzWm1zfQsk/3staI7V7ukEKlDWAsQGvV3+flSbaEUXNEwWQ9yZ8DSVzCDAN7MPBw0EAmJwjf7HLf7kz+ODXeJxYlCU0IVtXYW/cWV2Mrp/K132XKA5aZM1PDAnXSeWguLQbGhSw+xidQYUw3ROwWLJ76lDcbxiSsbC3sazpfDYU4+ArHE18sDl2gMDvhRTYFjjUO9qSVjo9hxntjMcR7g/5V6iirBctydV4TX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(5023799004)(6133799003)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EiwZmhR9VqhABjph6FJWKJJu4nUukCFbc9K5qXPC6DMc21lXYIZpOiiR+GxV?=
 =?us-ascii?Q?3IKrIN0mLoOE6C5eX6iAGuQHDoHhYVDLsQUed1nshrLHMejvkj4h4V6nJlhB?=
 =?us-ascii?Q?AGFTGAt8aK+XCqH01nA1nbqEa8VvkDXwS7xfO9fDevzL8XpuDImCnvRtf79F?=
 =?us-ascii?Q?EUHwmvEzOsVODkBu2G+7Nrhpl95NPAXyN45gQ6CJVXwSbUt3UtxSXf1kD4Ar?=
 =?us-ascii?Q?drfqZZVxjzPwxEKspovMUsXpGSlN0qallll3/1rMpu32yRw1EByHiG8dxKdW?=
 =?us-ascii?Q?K70G/nbv3TyGoXfyUhQvtt4FcTVtHsB9iuvGuqtxxskxq2pERvCQY11ilJ+s?=
 =?us-ascii?Q?IiiS8er9YTvaL8rRZp9EX3u5hoEcI13EFpWUyXQRPaCSY1Qw8xU3I9CrNFxc?=
 =?us-ascii?Q?7y0HHvEdJpHhx2GEoX27bhNr1lp5sH9c/U4rg2lOmE5SoAhINwVire0djNwQ?=
 =?us-ascii?Q?1cczFMXnkykTw7ynfmk4TGE/gNhmrYXGPPfBOrfjx45699n1DzJRA4cQf5l+?=
 =?us-ascii?Q?TxARau+ktU7xFtUimxSIaThaO6Kg7RAoSkVBNCKYx6Y5JdtjtzHTBN+pLFYe?=
 =?us-ascii?Q?dUuqB1T9VcxdUIpwM9xewwh/Kua3li6NqiPIRPYBv7T7Buk79Pc74AXIgcKC?=
 =?us-ascii?Q?f3CZ1NrTmqs/D8Ih6/QP2Cw33B3P+laKC/UExWZsp341/lBl83cAZq0eOsbQ?=
 =?us-ascii?Q?exGfs6KnNzPDU3/tpKKT3EDGqXzL6kH72HIRtnIqSb4CaJofI2qrumOSaXZg?=
 =?us-ascii?Q?8qYQchKCH8w6GhxrBS3fi229uyywPIaKEtHzAbEcQ6beRYSmNJBspKnn+kSd?=
 =?us-ascii?Q?XGZonNKwEQLYOi62raR8lOWMWo1LYUppjaT6yVnLNlMMRjIuZ/gjlm/NZirL?=
 =?us-ascii?Q?RdE54QKF9XXgQsIHqD7fWWK6vizx3DPDTF2fdGgWubDAf5qQEKd4Iaa8Zy5B?=
 =?us-ascii?Q?3y+R+YU4LAMhcDSU8iuu1+yaQCeMHx7RtZP1HlwLSv1YJ16b0OzkDrzRj0sc?=
 =?us-ascii?Q?XAfVgrb2YVs2fCSu+MwO6Y87vm8ESE4LmfnczP9MfUJ13LF1tvIXJCvk7TNe?=
 =?us-ascii?Q?uFXtGrVBms+bImf9KXEYSHUBaSYzhuxlTng680K36lco0XEP7oHLVb+Y+E7t?=
 =?us-ascii?Q?EkeysILb4zuZOMalougSknKpGcBxZKREu5TEwou/ohqcYZUYli9m7btSWK2C?=
 =?us-ascii?Q?uvoHhfJjcKUC4E4dACCovMAvQmXx1OflMbX8OpqKQFGjol1JneDxhS7JZGM5?=
 =?us-ascii?Q?7Tg6Jr9twDvd20Tvi7XR9y5BhD/O7WisdOaKw7xhXi+Z8dA0EtLkhMkKryGK?=
 =?us-ascii?Q?q4f8dWABNSLyRFu4vXUSr1x02ZjGHeRKu/n8l+v1SzN83fiQPk3tnKyQbmUo?=
 =?us-ascii?Q?dmemr7wqrboJmShXDsSi+TU4geUUMxjjYFMIyrtTAzKf37P2N1tftdCqhTYX?=
 =?us-ascii?Q?yKlPV4Q1RG9qMmIrNJAAkvKL4eo/Tw8dQJOD7LFYSJxs8vULtvDhvQkZ0GXR?=
 =?us-ascii?Q?cTCk8F2Gm3Ab7I58EPmNQbmu7473+V5pC0H7LtJ+Q7RrQ7Rp1/p688nmGZHu?=
 =?us-ascii?Q?0hwecjxR+Noc6oEf2lMywqyZ5410KthtzhgIFazk2dzXzpGKQnRapOAtInck?=
 =?us-ascii?Q?Q4zr5dLJqovXL07AoFNA0Ec8JX8lVJTJhgZ4LmICm1pfXRax/PlFjsBggjcI?=
 =?us-ascii?Q?GpJJJ4mTBnxb7ZzL2yfTjMPgTXl5iUSO1EhUjbHgyFOo3LA05f1PLYPXXEOG?=
 =?us-ascii?Q?eyLdcrrR/rk/IXyn0ZLanxV8Oa5+qFc3wzbQ410bP+lqwBXBVvqL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 223d9a2c-db00-43cf-bd0d-08debacd0a3f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:18:13.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Xe6w8nrg+xFEoD6FQmvKmOXzq0G9zn3RggBqiXt1IDOg7r59rhFvTLhNDjh3Md7t1uobOYlcHm+DivCqXCz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3700
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10888-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D25035CFC97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:05:05AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 5/24/26 11:34 PM, Koichiro Den wrote:
> > Add a function description and a user guide for pci-epf-dma. Describe
> > the BAR-resident metadata consumed by dw-edma-pcie, the configfs
> > attributes, endpoint controller requirements and the host-side DMAengine
> > usage model.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  Documentation/PCI/endpoint/index.rst          |   2 +
> >  .../PCI/endpoint/pci-dma-function.rst         | 182 ++++++++++++++++
> >  Documentation/PCI/endpoint/pci-dma-howto.rst  | 200 ++++++++++++++++++
> >  3 files changed, 384 insertions(+)
> >  create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
> >  create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
> 
> 
> > diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
> > new file mode 100644
> > index 000000000000..54caf4fafe00
> > --- /dev/null
> > +++ b/Documentation/PCI/endpoint/pci-dma-function.rst
> > @@ -0,0 +1,182 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +================
> > +PCI DMA Function
> > +================
> > +
> > +:Author: Koichiro Den <den@valinux.co.jp>
> > +
> > +The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
> > +to the PCI host as a PCI DMA controller.  A matching host-side driver
> > +discovers the endpoint DMA metadata and registers the delegated channels with
> > +the Linux DMAengine framework, so host DMAengine clients can submit
> > +transfers.
> > +
> > +An endpoint Linux system can already use an endpoint-integrated DMA
> > +controller locally through the normal DMAengine API, for example to transfer
> > +data between endpoint memory and host addresses reachable over PCI.  The PCI
> > +DMA function provides a different ownership model: it delegates selected
> > +local DMA channels to the host, so a host DMAengine client can request and
> > +program those endpoint-side channels through the host's DMAengine API.
> > +
> > +To make that possible, the endpoint function publishes the DMA controller
> > +register window and descriptor memory layout to the host, reserves the
> > +selected local DMA channels on the endpoint side, and lets the host program
> > +those channels directly.
> > +
> > +Constructs Used for Implementing DMA
> > +====================================
> > +
> > +The PCI DMA function uses the following endpoint-side resources and
> > +configuration:
> > +
> > +	1) DMA controller register window
> > +	2) DMA descriptor memory for endpoint-to-RC channels
> > +	3) DMA descriptor memory for RC-to-endpoint channels
> > +	4) MSI or MSI-X interrupt vectors selected through configfs
> > +	5) One endpoint BAR used to publish metadata
> > +	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
> > +
> > +The endpoint controller reports the DMA controller register and descriptor
> > +resources through the endpoint auxiliary resource interface.  The PCI DMA
> > +function uses those descriptions to build the host-visible metadata and to map
> > +resources that are not already visible to the host.
> > +
> 
> Most of the headings/titles in these 2 documentation files don't use ':' at the
> end of the headings. I suppose that we don't have any explicit docs guidelines
> for that[*], but these (below) stand out as unusual to me (mostly due to the overall
> inconsistency but also because headings just don't typically end with a colon
> IME.

Hi Randy,

Thanks for the review.
I had pci-ntb-function.rst open side by side while writing this up, to keep the
style consistent among Documentation/PCI/endpoint/pci-*-function.rst files.

If the direction of this series looks acceptable and I end up respinnning the
series, I will add a cleanup patch for the existing pci-*-function.rst files and
follow your suggestion there as well.

Best regards,
Koichiro

> 
> > +DMA Controller Register Window:
> > +-------------------------------
> > +
> > +It contains the DMA controller registers programmed by the host-side driver
> > +to submit transfers, control channels and handle DMA interrupts.
> > +
> > +DMA Descriptor Memory:
> > +----------------------
> > +
> > +It contains the descriptor memory used by the DMA controller.  The PCI DMA
> > +function exposes descriptor memory for the delegated endpoint-to-RC and
> > +RC-to-endpoint channels.
> > +
> > +MSI/MSI-X Interrupt Vectors:
> > +----------------------------
> > +
> > +They are used by the delegated DMA channels to signal completion and error
> > +conditions to the host-side driver.
> > +
> > +Metadata BAR:
> > +-------------
> > +
> > +It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
> > +bits.  The BAR remains stable while the endpoint function programs the DMA
> > +windows.
> > +
> > +DMA Window BAR:
> > +---------------
> > +
> > +It is the endpoint BAR used for DMA resources that are not already visible
> > +through a fixed BAR.  The endpoint function may switch this BAR to subrange
> > +mapping after the host-side driver has found the metadata BAR.
> 
> *: other than Documentation/doc-guide/sphinx.rst, where heading styles are listed
>    without colons.
> 
> -- 
> ~Randy
> 

