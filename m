Return-Path: <dmaengine+bounces-10751-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGp5G4V5EGreXwYAu9opvQ
	(envelope-from <dmaengine+bounces-10751-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:43:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 746855B713A
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC302303597F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EE4028D2;
	Fri, 22 May 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Kgqdwn6g"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020118.outbound.protection.outlook.com [52.101.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50438370D6E;
	Fri, 22 May 2026 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461836; cv=fail; b=IBvHGJFdfT/UMPMHkg2kvRnlrlwLhJgJP4c4JXo0syZChzikvKysqW1w6md77zi0F2NndaYsUN4u3bCY4L+zwO0qgsXr8XyTwgZk6Z5X4QGp/QQ8w8jyF4f6rKSuzF2IcfV6rnN8eVj4pDeIyS2KOem9n6cL1s9BJ1IRNoHfi7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461836; c=relaxed/simple;
	bh=VBzJWk+C1av6AC+7caw3Dz8pqi3PHxhvdZB1MtZfTt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBENu/J7KPuDc/mhV54PNF6cLtHDEK5AIn0PYvw344da0T3sKXOcOZUkTwHSiY4YlgoOLyq6jz0KzttKbMyRYJRBJrTkr9y00AuftC210XKNuMZ5iwo0K8GEn02PpPyDy3Mdy3lb3s5c8C9gGfMlmjpI+LLlwcyzk19L+wleZXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Kgqdwn6g; arc=fail smtp.client-ip=52.101.229.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1osKCHNkEGqe0hcPygnxtbbxBhVHs1kd6a+vc7BwPBtoa28F4QS+Lmg0T8bzrVk2OvzxJQIbyrj6gFyBhdPAa2t/kHtEmwvQ7Npo/gfcobUIRSgIhe8Vlu9zol8JO8W9WMxdjapkEx9EjdVzrRYbkMo9oHQynDmBbIx6CiGWue4GHs84IQk/aQ2SBc+n0/LeQQFbM8Sj3jmdqzsr8bcdqsv44BgPDtpvkqPQwQQ3yTntbiJA3hByJMFSdoOpnkUZQWuNfV07cTcVq8O0gPSXMDD0udD3LKUJ0qqUHJCXXbayMGWv7x7KSayiZyx7btYi4uqUULlY2IqTHRj6YrJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AupwEpDxNqiwhrMlUW+uqxqGfBWChRfZSO65KcZ/n2k=;
 b=ioBCm66ImPY2unMmsQLnMSPYY93Z2aapN3qbsTnpL4LJ2dtVsrOChE1LooLJt3T1Die7G76XYqojuWu/FQlLoSDm1emqmjPGup8ZeX0H+Ig1XziFXWVCKw9LkaQZe2rVi4heVopUxEo2qPeK7rt3apQGuSk+omrBopk3HSYJ48gvY2nBrMIbzt5GuLBM4Bx5XVYQMRZLGBMqi/M/AXU/UyBTF+X9vNnU/T9B8lwck94YizDhbvdzKmze9Q8m8iSzHiST6gD4JMdM/9VCD4fC1iY+pzdDoc7twfEzGEa6jvTqNvlMjMSXaO8eD24NJCUFfxP/27r3N+LQVxJigznkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AupwEpDxNqiwhrMlUW+uqxqGfBWChRfZSO65KcZ/n2k=;
 b=Kgqdwn6g2TZ4kg33vxTkKTZI+CASz5FLGa8SVvwChlgzpd0KQLqVX7Wbp/tUuScfYqZRKHWjl+ZtGuiCm7B/ORsuqtr5h2+FgdapfLxyFwk39+0n/H6RxfA3EsN2rXCfbbczmc8kysE5glvL12bCSYbonJl/mowWy0K18j0CWG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB5353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:383::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:57:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:57:12 +0000
Date: Fri, 22 May 2026 23:57:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: dw-edma-pcie: Add register offset match
 flag
Message-ID: <an2rkppyo3hz5g5vvpr2fy75bvarhj7aj75jh4x553yyu34eom@3y7vlucd2tvs>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-10-den@valinux.co.jp>
 <ag8wETTj4HhAxGYX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8wETTj4HhAxGYX@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2aab46-8bea-451e-2ad9-08deb81267a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0VptzBQRlsfZ+vFlWwMPuLcchZ/lSbpyHWFe+gE0OeY5sz7bII9/3O5Id6E2w2lM3AvH2AmA2yA/26YExtUCpkS6zNYZqcLj8wrQdUZzy3PG99etxffI6O5UZSUnJXcuNJHN7RJDMFRoWhJafqS7PoJxMaQvrnN8Zp2SX6ZMXFo3TpUHlJP4BN4WcYX6Y2T/pk0LfHqovvpU3UxgZXnYSBTL0h6BVnygRypHhxvedpl332uKDPFFX8mkon82eBhabfPpXPolIrweEuoqc3tVtAEhGyI8T9p1Rg7VrrwNF9bO6sZyiGaE8BbLq8wQmqrpa+dqm0fLvn1qP6R0e2VajXw5q547vp0X7ltxMzGqkAICFoYErlXV8vA0RV+NjxxHnesqfWJouYUW9ebIMVl7XMF+8O8r7l3DKhkH6VRAS8Jl9UCqPMfmJA+SpOyEFcXxWmmihyLxeUTrjjqx4r74SALiurVkUzYGiCdtTELT+dcMFnKg2LzA5qbkeyTQUNa/DoRMLpqU5wOINQxaE/6G5kLAOr7HUpQvHAbJbMooMjfLt/HFssMrxKEBpjwtpfVRPOwOM1sqGVbZ9Wmp5krLhrqCqQWHhw0rN4ZPQGbJz1LE5Z1x6mMRUqBRiFNc4VzTBk2tTABRJNNR17ZFnExXtIflHXdoT5iHQjVM+mNx6EmgPL1ll1TPB1v73AvoWNID
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDHwEKZOSI9pWy0aaTppoJ5b3lXs30feoQB/H+b4Ikq8HqhUPGWmjTGjlqwj?=
 =?us-ascii?Q?Xg3LbOTJxOTPkOcRalYUnKVWH6y5R5QvHYO2V0RiGzZwWyhEhlyK7ujSf6B6?=
 =?us-ascii?Q?J8aCk0Vf0aJwZUWH1SPzzcREUuKzZrlZjxNr+7lE/TMvIM9JJ8LiYH83CMyC?=
 =?us-ascii?Q?Qmavj4PegEY79+nwbHcpZNxtJTJ/BY0ZMx7/+VI2HH+jDuOiqeKktHAy8pOw?=
 =?us-ascii?Q?ptM2fp9WjFOj0V03VF6M7xJ9cGn5496n2RPlBWVQyb0rIBYnQoNqz7jFrI5D?=
 =?us-ascii?Q?kJi2uzaYrVvznfosG0ou0oHPO917cKrl8iuX5wZCo9A03lx87cbZfT8b1TMo?=
 =?us-ascii?Q?gZLDmGwDyDLLwtMXgkKi0raY0vzFFjUwof24Pk+qqteMOcoKHU1gaknO4UmD?=
 =?us-ascii?Q?OEZ3YgpKe/m6a8E8mP7H1u8iwwbGxjCw4cr1diTIF1S4d0wT1n9bhwC5Lu8h?=
 =?us-ascii?Q?rXZ7vrOxm0W8S0LD01XlL3fm60ea+t3Q1H+95ZLfPZojgAvW2v3v6xV7x03o?=
 =?us-ascii?Q?wI1ggDI3p5rIjLHKFiNT5Y8e17AdOrrLDCf/HhzBDxmYtOLRNfnjyrSPEmSM?=
 =?us-ascii?Q?0VpZjWvYcF02ZjHLQ9BvgeojOmHh5GCdbv+NTqq0BbqEzoJVc458qQOYM9SA?=
 =?us-ascii?Q?xZYwon5w93vH0uit/c1bQFkUNHT8QPzDQb0+uufleQD4bP6wyqrikwpp1pIj?=
 =?us-ascii?Q?03Loe3jXynHF8uDuAhcbg/xw/bgZUbosHAmDbCETxH34XZ/h6Oy8Sog3O1O5?=
 =?us-ascii?Q?Fwl7MmFiPQk/l18DnkAd0/eva5DYy93eVkjUa/8jWpdEc7WeQMeZ0p0Om5fc?=
 =?us-ascii?Q?a4usHlhTZoDvJJUNOTzqhUxNXJH0XOZ7Rkr7EupDIyFUW26PgAKzwcHT+xJB?=
 =?us-ascii?Q?rhNCotaNguvAcqRfhwLM4Y6fqWaPFIfdWweIU5I1dSNy1F8KlP3sTS36gXvT?=
 =?us-ascii?Q?XCMniWvQgeflnPZfUp83x4iO14dcfiqTDMabzo5vM4HdgOs4va0f1LlpO3kD?=
 =?us-ascii?Q?bYX00z01zFjWPjzZLDpqa0UhEXJyEkMa9b9sz6YMT9YtjF2zYbUs1os1D+gc?=
 =?us-ascii?Q?boMjQXFSnix5tFoX3O+grvYN1gdpGQ1UEepIS5BA0I3M+fXMYWOw6Msxc3HH?=
 =?us-ascii?Q?GRGVeHw05CV0iBgTIC+M6JUNL+7uSkOheM8ZYJ2lZDefcWlFiafIZ79pnfrD?=
 =?us-ascii?Q?8AbE6KKwbcHKk+f7+vhvt2lSKpv6fU6og/GmDSARGXMghe+OHoo+C0iP3Mz6?=
 =?us-ascii?Q?VLc/7atWYd3MxICrMV9kdHShbExsmahIc3/gtPj4CTh5VkF4asxAjo85uu0x?=
 =?us-ascii?Q?zAK7sCsnoiNbuLTPt2nmycz9+5uXPbcifIdmIhKHZwPM+xMF3spz2ntLSh/b?=
 =?us-ascii?Q?kH3OHtq7RyD1pQ4QPktwmQVH1CFs/r8RNV6MPYH9x/cHCY9S4Nnu0PwSX2uJ?=
 =?us-ascii?Q?xcaMOUmcNRR+0/P9iZN9PnuME0PTQnBAp6SuWTtUTxChk9v3OVDKIzhhR4TX?=
 =?us-ascii?Q?rVRWjMmtOoQ/T4Hi+FxdrOOc4ifEw3Rh8RGvQV8hIz5zxaf4/wKasBnHVKW3?=
 =?us-ascii?Q?CSg2YGy2PSFvHvFXNMEGW/7112dcgw6O4o+4iVzzPlR+dOMZ44fsnJJgRwb4?=
 =?us-ascii?Q?MhhRIYhCpIj0zXZVfx7Fy6hdwZS2tJ/gABLWan6IUl11E6IP0ijCqxaHoYu2?=
 =?us-ascii?Q?MHkpHKFZvX085vmr/PIT+JuIl4EIXWL0QEifHQwG/2ks3kKxI4W7KurYKBBP?=
 =?us-ascii?Q?/OxVdbu12swn8+l/I4HWuGv3IvZeU9drJ7+K6z8BifXl/gcTy6GP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2aab46-8bea-451e-2ad9-08deb81267a5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:57:12.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1imNmTiGeYxpr2t91IPmhI6/+f94GgNzlLDvTdI9RXWRlEdGMILMiFk8VRHe3XU01yokxyrdsmHJb3IcYD7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5353
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10751-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 746855B713A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:17:21PM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 03:31:12PM +0900, Koichiro Den wrote:
> > Add a match-data flag for devices whose DMA register block starts at an
> > offset inside the mapped BAR. Existing Synopsys EDDA and AMD/Xilinx MDB
> > matches keep using the BAR mapping base directly.
> >
> > No functional change intended.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 651269708cc5..6b375a58c550 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
> >
> >  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> >  #define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
> > +#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(2)
> >
> >  static const struct dw_edma_pcie_data snps_edda_data = {
> >  	/* eDMA registers location */
> > @@ -450,6 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
> >  	if (!chip->reg_base)
> >  		return -ENOMEM;
> > +	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
> > +		chip->reg_base += dma_data->rg.off;
> 
> suppose default rg.off is 0, so needn't flag DW_EDMA_PCIE_F_REG_OFFSET.

As I understand it, for the existing EDDA/MDB paths, rg.off is not applied to
chip->reg_base. The static data has rg.off = 4K, and VSEC parsing may update it,
but the driver still uses the BAR mapping base directly as chip->reg_base.

So adding rg.off unconditionally would be a functional change for those existing
devices. That's why I added the flag. Am I missing something?

Best regards,
Koichiro

> 
> Frank
> 
> >
> >  	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > --
> > 2.51.0
> >

