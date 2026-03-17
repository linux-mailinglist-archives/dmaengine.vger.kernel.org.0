Return-Path: <dmaengine+bounces-9459-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B8dBkPGuGnTjAEAu9opvQ
	(envelope-from <dmaengine+bounces-9459-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 04:10:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFB2A30BA
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 04:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AF7F300E19F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE112C324C;
	Tue, 17 Mar 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g41pGkag"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021143.outbound.protection.outlook.com [40.107.74.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474AC2BEC27;
	Tue, 17 Mar 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717054; cv=fail; b=FJOLlLYloFU28MeCXMiJfOY541EZqjQM4TiCgex/bIOuvHKLg9Ep/OaAfhCNE6MWXnRU2Qm+lbQ1SWQhROgqkYk8VlqmYB38wVg6OTRYqDLnrS24Tcm8QCTg2PjGLH7FxzHREyf4/JXljGDa9e7SbGzF+zfj8z0R33VJB1nwLNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717054; c=relaxed/simple;
	bh=hvY7bqA9HIEfqzpWKXqqVcgLtFTbKFE5UCj2ZRB47og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJcIl5Wtem7dGmmy8uqvEjIWYOfhzCX5JE6T/5apcyES/2zO6H4AduCtrbizI/WQhLDEcPmmKLdu3T8w2xg1nmIYU/HjRt3klr4KhJBVZi1E8Gh8B/S/9EapdkqUkEe9ty94ujm3NkZ2c7ttPHJIvR75eA03WL1RiscDudqCmzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g41pGkag; arc=fail smtp.client-ip=40.107.74.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+wcLsmU3huvfrFsNi/1/q7McYo/rpCckUlQHuqhO+wFTjHjmxun4CJl++zjLpuL1E6iGXb/O2pcP9Bw/1mvdjYYuI6MYUO5ftc06q6EGj8ZrRZpZaLSjn7pksarZZBbJ6J9/FljFvAVJZhuXAaV+ANEhMRgNGOvtX6baflTrwom2X8ME2hY1oiZo4YilkvsIkVrcyKhsOIzfjjHVf/JNZNPA0qQYRvYVbiPTAL2kEMhETcPTZapkkskZcqg4iwVIV8k7qELDeYMcH2LXYDJJ/kld5v95zI+wgsXt0lZuFuj95n9v6JYRFpDnjqkT0/60lYmf13jvCiJ7Kpc3pY7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vGKFMAMMQfydh9PqZtG/SAE5Zr7yKDktr21eovKvG4=;
 b=On/20QB8BOlV2ohSW+Pgu7gCVHFcjfIyni/l7agcNyF6WsrJfJE2xSc/bWBqOOI92E+iXgPqEzwjn+ol11VNBo8BXxGwYlpANsC5eY7MYSFHLB24RQbhy63VfS9D3uBXladPfe0NPryM9QZ7CzZDcFSWQoqtoqynojiF1QqTtBYZbSiRYZ38+13knK1BnAzfZkBnvTAAqnsHWNtySBUP/c1MAScFFtlogLkPMUBeq5RkW+JdSco+3od4gW6R6YRhEoEjCWPBpLsq5PF99zqDYvOTICyTlKhj9qPRFTl9pri4YX97pe2yys9fpcRbvsadpXQUqLyLSu2KS/n6JKDPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vGKFMAMMQfydh9PqZtG/SAE5Zr7yKDktr21eovKvG4=;
 b=g41pGkag+fSkX3wH95HnlfAorrVjfUKCvDCGTI9cCVv84LI3coMUyYuga24oViybSSh7pPreDDtFPFPMrcOnFX2fwO5Sf7RbvBnuCRXUffqn2+EuN2zxqTzXxqZcD1qbAVGZZ646uW+ByX83roifh7uSyXjR9k8zoeA3oMMAVgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2176.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 03:10:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 03:10:48 +0000
Date: Tue, 17 Mar 2026 12:10:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Jerome Brunet <jbrunet@baylibre.com>, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 07/15] PCI: endpoint: Add EPC DMA channel delegation hooks
Message-ID: <kvonmb54rqnjw3tsz7crj22wse4vlgsnsbwtsaa5snrthqbj7o@fzpxggkmfj7j>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-8-den@valinux.co.jp>
 <abMkhs4Ommy8P0D9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abMkhs4Ommy8P0D9@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2176:EE_
X-MS-Office365-Filtering-Correlation-Id: ca46fc6f-a163-4695-d506-08de83d2c9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7Y3gd+MvTPKjoUzQtic5WF/ascBwIi9fMGsog1nl09WsyyRLKBXL+Y3eOfOQNDOgGPdmyHRFecxG+Y7wlHzvO8zHhuZV/+MPJfVRFqaRR8hvUd7mLLkQ4DmSIPQr5G8NTnODcsdXK++HdIxKU0F742EF5iy/AJreMiJKThY+SXOeM75YEpA4AcVikKtKTtmOYrHNHfxu5+pE0KU4zLxLhKAC85/BUywK4ubiiVeoQpFbSOadpIFoj0v55St5EasQAe2FNaVes6hjJvdugL/+oD1vAQoEixDgp2SigSpqVay+X0iMuARy+TY0X8TRoUl3+UbmiQkjA4dmC+oq9FOkcOH8L3bIFVF9gZkftsszXR6kHOnHbka4fURZ1O9CCvnhokck3FYjYcofcNvJL1Dw5yy4JL26gFxTz+ZPW3M2rT9CtD8O+nu75Laz1FVXHHwhdxUZaAFq5i7QtKoCGplOEgEa0w05uJeE8/da0ZOnFVpK/gMFTAsdTS+4E0IWhW+Abm2dB/kv/XY5W9ta3mv9KMoZEaPdi/lr3KUbX1rIHAHrGhvHrlce9IVxDjvL6tQNWeNEmrZnwPucf9scsNfFkmll3JV+B6WwXaa2p0JNwVreS2rRV4u9RQxkQ2U5pJjLsd/nwu+5+UYT51uq3bBbR10WvU6kRix3IWWw4j1nSfPVBW+4lf6eguRv/1bxiG4l4VGN4uhhIGxOGvvQQszzgOCytsFNaLr977ZqsbZRusY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+BlGRi0rf092gpOK2DBrPSIOJza8O1RCO8fNy6yNkr5ccqe47CwL3ANfFhA?=
 =?us-ascii?Q?Jna4EN4pDakm6ZvCnA47SXKw0HnCx5Pa1DCDZWHuhwJX43dAnSgY53fObrdM?=
 =?us-ascii?Q?AzXe0717o4Qjw5CZ4uvnomLKumOHul9OgnyPIIRvCVaRC4/jKaX85hsVL616?=
 =?us-ascii?Q?mAJR+Ivfyj8qhMcat3j1ViFhRogeu3JmISW+nnnC5Y6x/QIeA2Bhn2ijsgHO?=
 =?us-ascii?Q?RqJyf8IK9jun4K6ZEepMabzoA14v1Hm49fTi/P7Lat8hQPBcpnwKxUgJsE0C?=
 =?us-ascii?Q?S0+oymSRzuKJUcB0ncpa+s6i32UkjJHL73sd/Vr/pBia9EVC3FPSYBNXE6Yp?=
 =?us-ascii?Q?MEStC223fjWWApL0QTe7PFD7Wj8XiFDT9nrlyT1Vhk9eVEdoh2NtN8GKrO2Z?=
 =?us-ascii?Q?SnAmXIPpSVJIMRfN8xmsV3vzG2qpFumZcP3uKz7O1FD2z/jYUujdFK97FDDR?=
 =?us-ascii?Q?mOu4kL7t2t17A5LXbxXAFqmcHxbs9/Mdm1w6u+4jKuTTXrTebrvRlacKE3p2?=
 =?us-ascii?Q?KEmkZb4VhNulph5rQqmoGVNfhc5wZGNIZek4qEP6jwwS22GuOPBXFmw63x1p?=
 =?us-ascii?Q?qTfAxBow7BSj00AAotBh6HBy6rlTJ7FoO2bnnb0fm1Z5sCjCSJk/y1M3MbbT?=
 =?us-ascii?Q?a3cLx9FU4jBTcwgRqLieA5FQEL+9q2IsTazAGwl0pQcMs5+JAv5zCyxsZJuh?=
 =?us-ascii?Q?MIhWMfGpAbT95UR8VRJsIsy/NqIoFvQMwoYpmrlWFy4jwRICIC6kB+YuyiEk?=
 =?us-ascii?Q?RLL/Mq2/cfmK0XhP9C87orFlVLB1xEEeJ+9646jQemfBWRSzFyHLtpjDRW/x?=
 =?us-ascii?Q?TSpjPOn0YH/+jeHZWQBNQbRSlK+7/TOBXxSCd/IMjCNoUQC9Zrcp39RVtzwo?=
 =?us-ascii?Q?7B8rZFC/TcTuHiCULtjoBkq1V3q5Il8GKfaMXqgE9RCwXltK5zeqwPvtkyr4?=
 =?us-ascii?Q?dsgKMUyGMfkSeFwtEQTKMztKC+prjWfIBLxAQo+iYyAJMG9sru4jnLnDX3bX?=
 =?us-ascii?Q?awBbyhYaK648Y+PWYjExR8g837zUYmsmQT/lRqV0mNlb+jRqZidEv0pDaCd5?=
 =?us-ascii?Q?Bj1viw8QKIKv3eCNurU5lEJuh/tODIVAhJsJbrjEreRucwznFxQtUDvJN4XE?=
 =?us-ascii?Q?ewzVH3PDsjChibX0YkkPRCV0cx3NeoYVl2sW4pPV4lPteBpjqm/IbliuKN0U?=
 =?us-ascii?Q?LHz/hktxEW2yTpgmQbqyHmXqOcpPfvHbtfMp77H/pVPfVL5nJrkcU3pr3I6X?=
 =?us-ascii?Q?rlVpv8FpmEqGBCEiC4faYl1QunJOJl1jmO6sEo7SUOgctw7dYU4Teu80H8ON?=
 =?us-ascii?Q?Oh+sH1MByu7YKylDeUEW7xrSGoPTtxacaY38A108/m06Jqbtu6JaEs2y04CV?=
 =?us-ascii?Q?beur+SzulWtAW4tsp86u+MrXAC+kHMQToTM5TyWA3H3dQhDubkNcvIV0GVAs?=
 =?us-ascii?Q?hf/YEZdDcapdSwO7u+mjfqRFdRTROcGN3YwyajycqCjrHH7OvfYWUoTyFnu5?=
 =?us-ascii?Q?oQV45leOaJNt/xiTJdcVXBv8VAKLXm5q5bEZP1LgegcT6xPrrLpD49OLld5C?=
 =?us-ascii?Q?v6nS5l2+PbQfb4uHCdw/zl+ITMyOg34tMujkzEfeDuVv3lx127OaVzYD19c+?=
 =?us-ascii?Q?fXE0BeQgFvGlnbzsIgz+d+aVGsBLuyFoRm3NqshoTFhTusZiy7vbSzcOvJuj?=
 =?us-ascii?Q?/xTF4Xp6tzhVFGPp9ad/NnSf3mAvCniMo/l/C+nvM0mEe8qLyr0t5AnVEfXF?=
 =?us-ascii?Q?6i7SwCmqHZx+/i+2lO0TNGoiRwdajgQ3u5kvLahy1QYSCyD1a9tQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ca46fc6f-a163-4695-d506-08de83d2c9da
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:10:48.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8Key1SSsrsRqkZwER7wipF0k/TzK77G5GyNaV73HjEy5qeWwqixDlmqAuZI//nLEDmci/K+yWjyyTY18ex8+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2176
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9459-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ABFB2A30BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:39:34PM -0400, Frank Li wrote:
> On Fri, Mar 13, 2026 at 01:49:57AM +0900, Koichiro Den wrote:
> > Add EPC ops and core wrappers to delegate and undelegate controller-owned
> > DMA channels.
> >
> > The exported DMA helper needs more than a passive "delegated" bitmap:
> > it must be able to reserve channels away from local users, let the
> > backend perform controller-specific setup (e.g. prevent the EP from
> > racing to ack the completion interrupt for delegated channels), and
> > later hand the channels back as a matched lifetime operation.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 84 +++++++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 19 +++++++
> >  2 files changed, 103 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index dc6d6ab4ea1e..892f7ccbd236 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -197,6 +197,90 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> >
> > +/**
> > + * pci_epc_delegate_dma_channels() - reserve EPC-owned DMA channels
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @dir: DMA channel direction
> > + * @req_chans: number of channels requested
> > + * @chan_ids: output array of delegated channel IDs
> > + * @max_chans: capacity of @chan_ids in entries
> > + *
> > + * Return:
> > + *   * > 0: number of channels delegated
> > + *   * -EOPNOTSUPP: backend does not support DMA delegation
> > + *   * other -errno on failure
> > + */
> > +int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				  enum pci_epc_aux_dma_dir dir,
> > +				  u32 req_chans, int *chan_ids, u32 max_chans)
> 
> Use bit mask should be simple, bit 0 for channel 0, bit 1 for channel 1

Thanks for the suggestion. I'll rework this part when respinning to simplify the
interface.

I also posted a follow-up to clarify the overall direction of this series:
https://lore.kernel.org/linux-pci/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/

So far there has been no feedback beyond yours, so I'll wait a bit to see if
there are further comments on this series.

Thank you for revieweing,
Koichiro

> ...
> 
> Frank
> > +{
> > +	int ret;
> > +
> > +	if (!epc || !epc->ops)
> > +		return -EINVAL;
> > +
> > +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> > +		return -EINVAL;
> > +
> > +	if (!req_chans || !chan_ids || !max_chans)
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->delegate_dma_channels)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->delegate_dma_channels(epc, func_no, vfunc_no, dir,
> > +					      req_chans, chan_ids, max_chans);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_channels);
> > +
> > +/**
> > + * pci_epc_undelegate_dma_channels() - release previously delegated channels
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @dir: DMA channel direction
> > + * @chan_ids: array of delegated channel IDs
> > + * @num_chans: number of entries in @chan_ids
> > + *
> > + * Return: 0 on success, negative errno otherwise.
> > + */
> > +int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
> > +				    u8 vfunc_no,
> > +				    enum pci_epc_aux_dma_dir dir,
> > +				    const int *chan_ids, u32 num_chans)
> > +{
> > +	int ret;
> > +
> > +	if (!epc || !epc->ops)
> > +		return -EINVAL;
> > +
> > +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> > +		return -EINVAL;
> > +
> > +	if (!num_chans)
> > +		return 0;
> > +
> > +	if (!chan_ids)
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->undelegate_dma_channels)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->undelegate_dma_channels(epc, func_no, vfunc_no, dir,
> > +						chan_ids, num_chans);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_undelegate_dma_channels);
> > +
> >  /**
> >   * pci_epc_stop() - stop the PCI link
> >   * @epc: the link of the EPC device that has to be stopped
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 7dd2e4d5d952..db8623b84c56 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -142,6 +142,8 @@ struct pci_epc_aux_resource {
> >   * @stop: ops to stop the PCI link
> >   * @get_features: ops to get the features supported by the EPC
> >   * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
> > + * @delegate_dma_channels: reserve controller-owned DMA channels for peer use
> > + * @undelegate_dma_channels: release previously delegated DMA channels
> >   * @owner: the module owner containing the ops
> >   */
> >  struct pci_epc_ops {
> > @@ -176,6 +178,16 @@ struct pci_epc_ops {
> >  	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  				     struct pci_epc_aux_resource *resources,
> >  				     int num_resources);
> > +	int	(*delegate_dma_channels)(struct pci_epc *epc, u8 func_no,
> > +					 u8 vfunc_no,
> > +					 enum pci_epc_aux_dma_dir dir,
> > +					 u32 req_chans, int *chan_ids,
> > +					 u32 max_chans);
> > +	int	(*undelegate_dma_channels)(struct pci_epc *epc, u8 func_no,
> > +					   u8 vfunc_no,
> > +					   enum pci_epc_aux_dma_dir dir,
> > +					   const int *chan_ids,
> > +					   u32 num_chans);
> >  	struct module *owner;
> >  };
> >
> > @@ -403,6 +415,13 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  			      struct pci_epc_aux_resource *resources,
> >  			      int num_resources);
> > +int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no,
> > +				  u8 vfunc_no, enum pci_epc_aux_dma_dir dir,
> > +				  u32 req_chans, int *chan_ids, u32 max_chans);
> > +int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
> > +				    u8 vfunc_no,
> > +				    enum pci_epc_aux_dma_dir dir,
> > +				    const int *chan_ids, u32 num_chans);
> >  enum pci_barno
> >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > --
> > 2.51.0
> >

