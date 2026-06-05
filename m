Return-Path: <dmaengine+bounces-11178-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EVpSD0g2ImqaTwEAu9opvQ
	(envelope-from <dmaengine+bounces-11178-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:36:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71D644B4A
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=HpvcLUoT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11178-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11178-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B1BA300118D
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA13B27C2;
	Fri,  5 Jun 2026 02:36:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7C36403D;
	Fri,  5 Jun 2026 02:36:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627006; cv=fail; b=Qo7woSMNGpaFzHAhaTjbH7gfBEpRODeiri8RPPKXGVlZDP4+ZL4ltcMIvPrbvWxbpSj9s0GoAWnXBXZC12ubXP58qlxmbP3zvJCp1zoyaunrqMIKhk4IdQzw5y6Im9Kqb4Dao9DBFRbZjbrpU84lccS1A8i3II6cGLqPgRIytoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627006; c=relaxed/simple;
	bh=PurKMYJwgeXHQ4ghq0d2DnCi9NpvasYlGTEM3lirtXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKHfxp4o9mfphuKk0XKZwbn2nDjf47T7+R9jpnMEIYCwNCSqxmwdvbRwz9Ko7bCNjITBxirdO4V4gJ0u23st9I5v6uWO/q20l4IL2f6wowlm0tkQkq9BRvhE8otHpOywLcgRJRUj0uWnT4HtQw3HVwS7rWsRIC8THmwtA0ASeDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HpvcLUoT; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYE3iYInr0qmGqJvZMsJQ+b5UdJqNNJR51oMtKe1qsi4tDiSG28gkk9i92tUnkV7TjA+H6AccwPmtVH8yMqW9t0OEQwX4g+i1dFhYc/9cxVzpaTvlbwPraMjCnlSgfe/wbH3c4jrNX507830KTvU/HEx/ULEleehvozBwVcOSELydnW9WUbTIRZmEtgRhlrMY6KXxMeCOhPpUXCa6VjlWL3vcvAoOfNtvziKJzIMamBT1bUlTbWBbKPwZJNEf+j5we6rB4mypCGvcZHaeGNNd3vASrxt06S1d5ShdkB6a+R09tb8G1mqB9QLvdzDszfB5lLc9/xNNl2ncMFh9f9/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZEl//5Jd2Eglt+KAX6Hxb5Zwsvxbd2C3NgE+IKobYg=;
 b=EtKJ1yMLg9d2E2hrA6ZQcH9wdAUbJAHJBCSswv7VFue3IoheiGT11wgTtknRZG9Wvw1e+mfl++dqb/KdKzE8X6PkV9nFcAtMEsmtcS3fxWF82UcvMXbypNZVEzSHV58kq78B6sCNPMv6i2kzndAxsivMiipTSJoECu82d2mMvOBg0FfPLL2Jum1Mi9crDDz7gUMkDlXVNhvS4ve0nVeL9mktWrvZcME8/Mqwe1TuZOBSv0S8asBu94sBfAo2rpwGQA6jRAzJQ4inZGkABnEDNUWDgkUS69W+/Vl4gN9X4LrD6v/U/nnbRd2tn+G48Iv5ScoeeAasDWK25+itt3cJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZEl//5Jd2Eglt+KAX6Hxb5Zwsvxbd2C3NgE+IKobYg=;
 b=HpvcLUoTv5gox5kZLZRqpTsFEMNF8ySJrVGx9MHMlM988zhFm0lrOGjg/vSp3llCeQW9XPkj079e5QG4pfQDHKnKD8T7kLTvUzPyL7cvq9PIAoQzkrsBfWnj2hFGU5TNcBdTCh49FO+BpnLA9v5KZNsaVO0jByzH3+PqiPExOds=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYVP286MB3715.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:369::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:36:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:36:36 +0000
Date: Fri, 5 Jun 2026 11:36:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <3bcdwnzw7scq5y45vjl2yd6c3kieyi33rtron4fhln6b2d2qpd@itvhlpnetjau>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-3-den@valinux.co.jp>
 <aiHdevABZTFTZ0Pq@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiHdevABZTFTZ0Pq@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYVP286MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a89e64-4520-46e8-6d71-08dec2ab4359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|6133799003|56012099006|3023799007|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ayNyn1hvBPXQo8H98/XvQJZ6PUnAp6SZ7Jkgl3WnIJhVRdAZiIJw04Ae/1EZlAu2Je3sZvNh7Cx/4imlYLAXzHGxPLMBgx4cSrBZ6LeJLxgVYzdVs/k8drKRLUhsP6CxuKpo1LCGgoDHB+rbac2/tQboE6KhwiTy+diGUSL9AXNlMgyOWETchuWi/d0+Jb/1LdKqnzyEJMr9Zy8CPtcqh7U2Ex+RfKzfGpBo+hqZ2sRPlhiMomHdumUusfYG/tgQpTqwXtsNwDJgo9r4HfiXBdZtvv6r0HTWQRIRXaqkEQdobEXdTjvcGLYa64p+W59wjWa25gOiJmzkBIp1sXCH+dW6XL0t/06EpSLMbnTz1PhukaAwmc9AWPk5HBVJhe25X2f5Op9X91LaXM/cNZRuBVnGlJCRqxxTFj6nloIX5RYqXCDSB4h/JjwgYtbHWTMC84Y1y/TCTDJl46p+AaNgAaxxoetygJsAZOSITFvRmP7NqeokoZEUAxpf6zOBAwCfrCkSteRpv51VWS96ugcxc9JfzF9pi+fjGpetDsn432CRAbTbNIFAijlSJbeiDx4pCjsq8ACULfqWO4QoXYgr1xdM5WgkiSU19s59y04t4E+qr77QfbxBZ6VhFbbaJo3odGYovr19e/0RvZ+4X7C89IKdPIc/5/5GseX17ibkXj+EQn0KjG5GBk2YpX5zat5+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75Xw4R6cBnF/QJLxR739+WmllDBCZdzBrA8Lwo4JYS+/io4J5KYjCZDtCHpn?=
 =?us-ascii?Q?F6XBvJe3RtzFRxd+yaLMQPyFJyY/muWHnZf2y326vmsBm/0+acDhnEvfPBQp?=
 =?us-ascii?Q?DXswZn0nS7+m7OkGOLpiOd8jls2oX4O4RKuGALn6Hy5LZY+JvB9yVPoT54j1?=
 =?us-ascii?Q?W67lESHUf2wvXeaYYcG5YfmhbFaH0OWHUrFGIZyI8VgDDBwoTPjW+okgTcGG?=
 =?us-ascii?Q?0dLG0OhF1HqCjpzzXbZay9iMywEXXjRJAe+naaWNfDWI6wrniqd0Jxn5iYEf?=
 =?us-ascii?Q?NWsU8zRin9+V34vIJ1wQno7pewYMxWD02JjasGrTBmMxEwNw0otpknpqPiG3?=
 =?us-ascii?Q?HnIEf3BfdG8nIP0f4GLOHrrIb5o77iteprrFWsgELf/0RPa+I/774WCnm/DU?=
 =?us-ascii?Q?Fb4R9t+qpxZLaywHOwYKwEliiKsvBdVG35yvM4ELRjztTFxG+cqkvG2N3VWt?=
 =?us-ascii?Q?hCVPE6A590ayP+5mkzTy7/d/8yl6DwX7FKUubgapO9YnlCMXV5Irh5lMpkqJ?=
 =?us-ascii?Q?VtkRYaUh7txbSeRQ0v0eWp1CmbPEUsEDjEzlsV/c1Z3jnfeHzENMgUjHTrDD?=
 =?us-ascii?Q?4wkanMejWuhS5plmdbxyG0/vijPHBwezPV3nlNcsLRR6PfUk7Ufb4twCraof?=
 =?us-ascii?Q?ceoq4cWSli7tT4wXsHWK4EQvhXlcvXkvQaiT2vePwPFlZhuy8qdyVR90O5Vi?=
 =?us-ascii?Q?N4jVTDSEF9ZAzHuQbHVY16fs6rSowuyI7c/1bUb45MV22UInWomB9hxT6I6G?=
 =?us-ascii?Q?nr3hu3P+CySlQxTI4zieSoZcf5k42Ywu7L5jbSBr4rK4DxzWpQiqJh0QAo62?=
 =?us-ascii?Q?zpZdC04pI/pKoIzLYGkopXW0jEpOtYmwPK463WeIpXR8To7FSeNPLMqb+QM8?=
 =?us-ascii?Q?ybrxeeVoSvJgeyli963Eer082w4YOK99iEUs0sWwUvYrLlxTQc2Td6rI6L1m?=
 =?us-ascii?Q?iz8Rv/pAojB/J5tE1pm1KV8NtkbuT7ElJcT1HF0szO1kLBXHx64a2t3GfcwY?=
 =?us-ascii?Q?H4I3ZcDAmaY+neP4lnzvkly+danLAoL4xr6hBZEkiZmNcVd5nx3KLqMXC0m8?=
 =?us-ascii?Q?Vjxf/Is1ci9zOrtAfGmZE1+3RJk+2AG2kimLunHDqggFQBmbwR9r8dqb3E+B?=
 =?us-ascii?Q?FohVmcXGx6M3Q4me4pT8nSdpT0niogq71mIqOleuEIoeukaqr738VIVHkS1S?=
 =?us-ascii?Q?5nYY/MoOIWFl4r/2uO6UZteegerbmx1c9nwRhNWUFcfKXGIV3ysNeRgkQ1Ve?=
 =?us-ascii?Q?X1BqT3cwkKhWyPMpKyIwZWUCXwcmlXgnebkpDSsedwkC4d/ojEXmUz+ERnXR?=
 =?us-ascii?Q?SZnJsuEn3EOpoI2tq4etroxFt5YJKteYKUiinpx9M8sgXxrDzz5QZbmbiSM9?=
 =?us-ascii?Q?wAL4j0rPpz6rz2oombaVluH3EulW4OSO8Mr4P+Xoh3MOyssqtyc71ug2vV5h?=
 =?us-ascii?Q?xJarYNVTBegU6zHDj5hCs34XDMkx+KSpTRnadKy4kOUxXrUgzczJI4yt1LFx?=
 =?us-ascii?Q?SJukmoyllF1irKildKnsadBCwxT5zQV9FErh4L3XYqwRH6qJY36x6sXdGtXH?=
 =?us-ascii?Q?aUztsq1CXOHLvv4GqQ03VyEC5Bm0aJOup+QCsz9pGhmv0Tx5JwdFXI6u8HWp?=
 =?us-ascii?Q?N+5Qd4wF4FXtIMz1dNZP08/3R1ke8AGRlHM0mpUushvOTHB6GfQ8XVdt+nQK?=
 =?us-ascii?Q?rhYLUwa9f7vlzBUme/Fp2xH9bDjeGcdaYt4tQbHeDwLjkAOAjSL/0EdCrddP?=
 =?us-ascii?Q?en3OP3nBOMborcddTCDmm0+jcz4IZnj6iTNPxO9mKiF2+32D3WRQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a89e64-4520-46e8-6d71-08dec2ab4359
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:36:35.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCdCSb8aRHpSFVqVzZlj21HfK5OTjz3pwhdh42BBdqb6pTHXGTg69Y/WsRflvkBkKPmAZiXDsSNZoGcmBe9Xzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3715
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11178-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:from_mime,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E71D644B4A

On Thu, Jun 04, 2026 at 04:18:02PM -0400, Frank Li wrote:
> On Mon, May 25, 2026 at 03:24:10PM +0900, Koichiro Den wrote:
> > DesignWare eDMA can signal completion locally through edma_int[] and
> > remotely through IMWr/MSI. When channels are delegated to a remote
> > frontend, the local endpoint side and the remote host side must not both
> > service the same DONE/ABORT status.
> >
> > Add dw_edma_irq_config, carried through dma_slave_config, so a frontend
> > can choose default, local, or remote IRQ handling per channel. Update the
> > v0 path so linked-list interrupt generation and DONE/ABORT masking follow
> > the selected mode. If a frontend does not supply the config, keep the
> > existing behavior.
> >
> > HDMA native already uses dma_slave_config.peripheral_config as an int for
> > non-LL mode selection. Keep that interface unchanged and reject the new
> > IRQ config there until an IRQ routing model is implemented and validated.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> ...
> >
> > +static inline bool
> > +dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> > +{
> > +	struct dw_edma *dw = chan->dw;
> > +
> > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> 
> suppose it should be pre channel config, why need check chip's informaiton?

The irq_mode alone does not tell whether this Linux instance should handle the
channel interrupt. The decision depends on both the per-channel irq_mode and
whether this dw-edma instance is the local or remote.

- For a local instance (i.e. EP Linux), interrupts that are supposed to be
  handled on a remote instance needs to be ignored even if edma_int[*] for that
  is raised.
- For a remote instance (i.e. Host Linux), interrupts that are supposed to be
  handled on a local instance needs to be ignored even if IMWr for that is
  raised.

The both ends sees the same status/clear registers, so the non-owner side must
not clear the done/abort status for a channel that is supposed to be cleared by
the other side.

> 
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > +	else
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > +}
> > +
> >  #endif /* _DW_EDMA_CORE_H */
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 69e8279adec8..08ec2bd7856e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > +		if (dw_edma_core_ch_ignore_irq(chan))
> > +			continue;
> > +
> >  		dw_edma_v0_core_clear_done_int(chan);
> >  		done(chan);
> > -
> >  		ret = IRQ_HANDLED;
> >  	}
> >
> > @@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > +		if (dw_edma_core_ch_ignore_irq(chan))
> > +			continue;
> > +
> >  		dw_edma_v0_core_clear_abort_int(chan);
> >  		abort(chan);
> > -
> >  		ret = IRQ_HANDLED;
> >  	}
> >
> > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		j--;
> >  		if (!j) {
> >  			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> >  				control |= DW_EDMA_V0_RIE;
> >  		}
> >
> > @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  				break;
> >  			}
> >  		}
> > -		/* Interrupt unmask - done, abort */
> > +		/* Interrupt mask/unmask - done, abort */
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		} else {
> > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		}
> >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> >  		/* Linked list error */
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 3e15cf83b784..2bf2298711e1 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -60,6 +60,43 @@ enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> >  };
> >
> > +/**
> > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > + * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior
> 
> Feel like it make things complex, most likely use pcie ep probe, it should
> be use DW_EDMA_CH_IRQ_LOCAL.
> 
> If probe from dw-edma-pcie.c, it should be use DW_EDMA_CH_IRQ_REMOTE.
> 
> Add default mode, it make check logic become complex.

Sounds reasonable. I will drop the DEFAULT mode.

Thanks for reviewing,
Koichiro

> 
> Frank
> 
> > + * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
> > + * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
> > + *                            while masking local DONE/ABORT output.
> > + *
> > + * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
> > + * bus, and remotely using posted memory writes (IMWr) that may be
> > + * interpreted as MSI/MSI-X by the RC.
> > + *
> > + * For the v0 eDMA programming path, DMA_*_INT_MASK gates the local edma_int[]
> > + * assertion, while there is no dedicated per-channel mask for IMWr generation.
> > + * To request a remote-only interrupt, Synopsys recommends setting both LIE and
> > + * RIE, and masking the local interrupt in DMA_*_INT_MASK (rather than relying
> > + * on LIE=0/RIE=1). See the DesignWare endpoint databook 5.40a, Non Linked
> > + * List Mode interrupt handling ("Hint").
> > + */
> > +enum dw_edma_ch_irq_mode {
> > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > +	DW_EDMA_CH_IRQ_LOCAL,
> > +	DW_EDMA_CH_IRQ_REMOTE,
> > +};
> > +
> > +/**
> > + * struct dw_edma_irq_config - dw-edma interrupt routing configuration
> > + * @irq_mode: per-channel interrupt routing control.
> > + * @reserved: must be zero.
> > + *
> > + * Pass this structure via dma_slave_config.peripheral_config and
> > + * dma_slave_config.peripheral_size.
> > + */
> > +struct dw_edma_irq_config {
> > +	enum dw_edma_ch_irq_mode irq_mode;
> > +	u32 reserved;
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > @@ -76,6 +113,8 @@ enum dw_edma_chip_flags {
> >   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
> >   * @db_offset:		 Offset from DMA register base
> >   * @mf:			 DMA register map format
> > + * @default_irq_mode:	 default per-channel interrupt routing when client
> > + *			 does not supply dw_edma_irq_config
> >   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
> >   */
> >  struct dw_edma_chip {
> > @@ -101,6 +140,7 @@ struct dw_edma_chip {
> >  	resource_size_t		db_offset;
> >
> >  	enum dw_edma_map_format	mf;
> > +	enum dw_edma_ch_irq_mode	default_irq_mode;
> 
> suppose it is pre-channel config?
> 
> Frank
> >
> >  	struct dw_edma		*dw;
> >  	bool			cfg_non_ll;
> > --
> > 2.51.0
> >

