Return-Path: <dmaengine+bounces-9375-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O13OQVqsGmNjAIAu9opvQ
	(envelope-from <dmaengine+bounces-9375-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 19:59:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C034256C11
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 19:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC1E3086072
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66F2FD1BF;
	Tue, 10 Mar 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmq2m8Ru"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945843939D0;
	Tue, 10 Mar 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169154; cv=fail; b=FBSvmNyWlqLbhklK2ngFpXICrqMyVrgoXzf69gn2IrZfOwyZDASd1eBtk9ik7v0Ynonen3FVBScYTzy8j0vVJuibFW7gu7wPvtiigW3k/4A2d5rt/FJIC7xfAhre9v52bmqdmKjKjQVuXnme70V1HNO0qY7NPb+JW6Fw/1l4w/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169154; c=relaxed/simple;
	bh=wgXuKB/aFAmo4Pk0yTiK+KziJroL9UMdrJtp4B9ZIqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eRZVO1kgy3sUqbYRvMfC1cp1xVTaY0XIL7rt8rb1xLhL2JI/7xUHdxBW0gaYt07xYOQVEgVeeyPWanoToWpaBN9go4/ItbMy624wauYw0uGK7k66g9krwRufGUHscXqUrgzxKODEw2v+t7jL3HRdZzsCSS5XJb9ZA2nuHewUp/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fmq2m8Ru; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIORfA4nU8aKY0TOS1lUERU4nodyMzf25lQwu88HRSnQ/CoESI95IA8Hgum2fDTBrEHcxU7PfMSYenUbDGmLRdjFgFShIYIp0YXYYrN1G8vAlzL4lgDSRk//zKqHch+oEGUw+4XO9DsaQWz0s7VURsN8HvY7KLKl76L9vLkfKYVNHZEnGEtzArqHend+o2um+v5myR6XKM631DOAq8aYI0ZGLnvcwAGjXC4UiYCOuLLqQ7DLy+XoOz6sLKLkKi8J1MDN2i6OYVRtogJuNMua/fBtptduYSEyEQyihK8+KyDkQAvQjBZDW7LTPuU105VoXuu8mI4pxKuPgAxv+zvFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do1m7uKpDfhBlcHVlPKYvZKsr66C+JFsAlljP1m2Gl4=;
 b=lN1E0j9c+FAjXMOliA+OXbzQOTt2wm1d8aoR/c48t4YCU7A0WWqTGZUi+dT5er7qbN+YMtQ/QSD+YmP/Hiiakp/LCbIhZVSTVuuVt55Y8ILLs3tP2ngJCbfYImG0hYKL+Z2EGjGaWbRM8SGRHYY4OvLTwyh9hBbND+PGE+/2xt2DOqJclmSvgNqkF6ylI+caN3Hg5hq7xAXC32EKMe7keVnqkqpl5pFLZUm34cbL4Y/hDchFHn562EJBXwKXjOuCMOnrwSB6o8tZ6PHbnGnR2nY14s14ONtGm4MmkWOcV051s6EfdbXDu49AoM5McUqZLtew6g+kOx+87U3DzHVfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do1m7uKpDfhBlcHVlPKYvZKsr66C+JFsAlljP1m2Gl4=;
 b=fmq2m8RuTEX/PZ/LEee6r4TvFTYh8OXl4BiU1RrEvTQ001HAXGr2dr2t7i3PiIOmJ7ZwMFJTitELDHU+y9Hw8foXz9Tl3E2ox7KM2XY8UY/poenpOTCSzq53kRYMmiXrPjFXIXxuNbJxs3VvOc5EhNgsgfG7tvK+qKQDcSwhwzdYm3c0JMPvmS0Vi2GENtRX/7swNDVtDZWt4glDhGIxejmNq+h551wx4Z/86n57+XFCie7uOa0Pn1zVgL/MS8IDKUBlX/dxiqEv7Di7UUuWzW2ldF8K95sOywem6ctJ+4oaSZAt4Dmhro+5LaLcj010lPS//+D2JJBPeQz1DIQheQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:59:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 18:59:07 +0000
Date: Tue, 10 Mar 2026 14:59:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v12 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <abBp9dh2DRAKfDJ4@lizhi-Precision-Tower-5810>
References: <20260310123055.2863727-1-devendra.verma@amd.com>
 <20260310123055.2863727-2-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310123055.2863727-2-devendra.verma@amd.com>
X-ClientProxiedBy: SN7P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb18f15-3f40-4c7e-284f-08de7ed71b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nC+JOZ/K1VaiugwCiu9Vg+KYzephqkRsuigDLkY07HD82QpqCLSBlXQsipcwWPyN+a8RKT3/kt0MOjj1Uh485EYQ3dNr1atcoAfK8dgBU0ZAb3VV8XY+TctBHy3yEpfWwJlzU4D0ZH5M7e43/MRa9GdPCTL+zXTrBaxsTlwb1rjyqrqRzZI4c4Eu9aSI3BIFsTZJF/jcwyjXLrTtzAIuXowUgM7+92Oi+YX2CaTjXWWmQuscQXRjOKgTZuXIpmlgNnBoi/64Ovm4XYhYIpvsuHJ+91Ak5xx6Y1M1N1H16mCxd6T30ggjA6z7972KH7EhpfhlXi3wDifp16XHO9POsreizOCsdmbNLJiR8WpabM4wqh+ippoHsQmE4zSMCbBy0DFEsyGmA9m+Nx/b/DwrlwOIbMjB+7EGFJlPgngxKZO3wfbXmf40xSGtYB+wKDBJGijx7GJSLu/JC2YXQ2579Ix4V4qRh46iKMWRDgVtVyeApMqu2dQABFaZKYYjKYs95BggtN1u3qXD9OFjlTN39CAD0XRJSlDwnJKoqxWJnRsUysTKSAWPFZGn3kt8D+6i09MBss1fHW+furwfvvWrwK/OlNfZZgSsELb4mtDl+/M5F945wT586Ha8Qk0Qd0nS5BiQdxVRcYJJWFtrvmy08NdL26FVLMwdgG5J1hC07QrZHzFvn4SPZJmUlWGjfJBEOeHixqZOUVUEpLHILWpiu+S1QWO2nTiE8Ip5fQCo3EkQdBMtLpCcO9Uv2SQlb/tztmAGTewN+2xZK1HF8pjGTJzYJm+QWvEkX71HUjpdBb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/E/SlOhNM9b5+NsZpiwcwBZLEORYWNDfn+Qza41rdcvHuwutLCuQ5o/vogb/?=
 =?us-ascii?Q?eYyo370aMiPKSpEyK5n9JihOBYd6A9puc92g3lY/qwnHYCEtoGOHnoF48yOs?=
 =?us-ascii?Q?E0SykLXyRsdfA5NLz0miFIbgLggkunX3G/5SG9WWuE7x65UxkfESIvVvBad5?=
 =?us-ascii?Q?6QZXnugjgjdoHC/9vvmXo5B+psWVB6KNUQLXlT37RproOGfZLXURXS6qA4h/?=
 =?us-ascii?Q?e8ZfEQUNZovhSTBiZVK0z5Ya6FSq3TB9PQFxh5ri5yklG4DWK1OGsDL9ACqN?=
 =?us-ascii?Q?pyiDKJuWd+i+AuH8tgFZuMG5v6jR588PMmphjLIGyCsVdGUFp49dO+OesEk7?=
 =?us-ascii?Q?1AfwdM66Y8DwJVwSeuv6mAWW4u0iR0wnP5yldbtkjsN3xpDHNDQ6lU3lpGdP?=
 =?us-ascii?Q?rb2Yn6pEYvIAbD6FcXP1+E9zOICGIgxGVXkK99mg9TnoBTbeRv3XDKi4qhBO?=
 =?us-ascii?Q?VvxI0JQ++ivrSTfnuDneTt+wA//lnf1CLEDwnSN1LSVLjuLPqoKmm6W8HOJt?=
 =?us-ascii?Q?CquuuZLotKNharBcV8Jk6d4zLTso0QGCsscQi80en44ijqyCclclWAi0EdH5?=
 =?us-ascii?Q?R5D++ksU/tyGV012lA0UV7U1XHzuOhNvqW0TmOKW4y74GUGb3MUeZX3+5ORA?=
 =?us-ascii?Q?IlNOe/7uR068QALnX106HAzWj/vCLPWDmiZzpkUzJ22Wav+MPyKKJBzZgy9Z?=
 =?us-ascii?Q?UTRXUBmU6GChqrkTpR5bU2lytzbmKTOg49+o140+exEaIyeHBkd5lS/j33Mx?=
 =?us-ascii?Q?cqDUm7JNarldfOFTain6Qe6GMXT75SqmZtpbvjiuSLZqGDzgNRHI4c4JpIo+?=
 =?us-ascii?Q?dQppPrSLwu+3OqDTD213bURzgNzC4/bFDeA0RGdeq9QHkF+hXxKEmsozolfm?=
 =?us-ascii?Q?I7HIQ7Hni1o7KoJWsj0juFujV6Za6De8l6rCXDGBRdhl8OsQ+6qlhIF6BM5r?=
 =?us-ascii?Q?PeskJ+YBDjYD4q/KigJ0ogFfADS3kqXsQjVYW/4FnNrbiC4LRhVCAMgr0i0L?=
 =?us-ascii?Q?kJnUGYnpL9FegALyabvQK/j4lbB89bxiaCEIMbTFhbfHVjHhmc3qYbFNoNYN?=
 =?us-ascii?Q?YL1TFTCa+Bn3GBhel8HHS+ssQFSgsGmHCOiEnrG+rivRd6vJN1/QxVJAZp7X?=
 =?us-ascii?Q?oPR+ioqwXTBj7lnRWaQ9vM/4eqqDBlN6dUigdMOHTn48eJCgowgpnIwGEjmY?=
 =?us-ascii?Q?8Vi9ufkR4ClPJfv7/4pR16pIrTkVBB6cW6Nd60xc+O3iTq45ZStFXZdtxzun?=
 =?us-ascii?Q?UZo9Celw08MzncKlV2XJvszBqk198pDJmw3zH0+yKYWVRsrLzKt5HlEef4lK?=
 =?us-ascii?Q?fwQHCTRrIA83cUm0AvJ3RJiOd5EEB8Hqk1UW6pYHcweFfhfyyu3dt9rJUVsk?=
 =?us-ascii?Q?5PsgeXRVIsgRPXcwCOoK1Sl/c0GcI4pelUMOrNj/WXyxdmym8/3dBta/E9RF?=
 =?us-ascii?Q?EeP3hsFUW724ivyUkCr/4Nt/LnYplyyT9bc+0t/OKkDmJDFmprwhBiCARNe8?=
 =?us-ascii?Q?d1iErvmcl8YO4Ce0E8mps5dZ25n7S9rbujnJVRkBr6HAg122DejBbEMmmVTG?=
 =?us-ascii?Q?WETU05mKxqbFhF1R+n8uuqIN2wDd7cUymtzi67DrNdQ0b/l9zZoPW9SuKkR6?=
 =?us-ascii?Q?AcHdr0yaTpycsVT3jXov21x5L+Wgk1ea3rAYMF2pEY29kIJu/afcGps/InmZ?=
 =?us-ascii?Q?ztyefJSxlSiRzDERYHvMZqe0hZYp4W+rqt8PUTIo1tFFsSkx9u7R6L6dKD0l?=
 =?us-ascii?Q?mmEP2/k8FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb18f15-3f40-4c7e-284f-08de7ed71b52
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:59:07.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8qMxOynH2sEMVVeKqAcZNz/qw5a63AVQtv6ouF/t5GuHLf7TofKrDIUOjfqzPVKnQZT0SrN1Kv/49eSwVbu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627
X-Rspamd-Queue-Id: 4C034256C11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9375-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:00:54PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---

You missed collect my review by at v11

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v12:
> No Changes
>
> Changes in v11:
> Replaced min_t() function with min().
>
> Changes in v10:
> For Xilinx VSEC function kept only HDMA map format as
> Xilinx only supports HDMA.
>
> Changes in v9:
> Moved Xilinx specific VSEC capability functions under
> the vendor ID condition.
>
> Changes in v8:
> Changed the contant names to includer product vendor.
> Moved the vendor specific code to vendor specific functions.
>
> Changes in v7:
> Introduced vendor specific functions to retrieve the
> vsec data.
>
> Changes in v6:
> Included "sizes.h" header and used the appropriate
> definitions instead of constants.
>
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id,
> revision, and register offsets.
> Corrected the error type when no physical offset found for
> device side memory.
> Corrected the order of variables.
>
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor
> Added checks to validate vendor ID for vendor
> specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx
> Added the LL and data region offsets, size as input params to
> function dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function
> for Xilinx specific case.
> Corrected comments.
>
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro
> and condition check.
>
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the
> functionality for setting the LL & data region offsets.
>
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
>  1 file changed, 176 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a76d3c..b8208186a250 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -14,14 +14,35 @@
>  #include <linux/pci-epf.h>
>  #include <linux/msi.h>
>  #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>
>  #include "dw-edma-core.h"
>
> -#define DW_PCIE_VSEC_DMA_ID			0x6
> -#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
> -#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
> -#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
> -#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
> +/* Synopsys */
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)
> +
> +/* AMD MDB (Xilinx) specific defines */
> +#define PCI_DEVICE_ID_XILINX_B054		0xb054
> +
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> +
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> +#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> +
> +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>
>  #define DW_BLOCK(a, b, c) \
>  	{ \
> @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	u64				devmem_phys_off;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +112,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>  	.rd_ch_cnt			= 2,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_mdb_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= SZ_4K,	/*  4 Kbytes */
> +	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
> +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> +					   enum pci_barno bar, off_t start_off,
> +					   off_t ll_off_gap, size_t ll_size,
> +					   off_t dt_off_gap, size_t dt_size)
> +{
> +	u16 wr_ch = pdata->wr_ch_cnt;
> +	u16 rd_ch = pdata->rd_ch_cnt;
> +	off_t off;
> +	u16 i;
> +
> +	off = start_off;
> +
> +	/* Write channel LL region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->ll_wr[i].bar = bar;
> +		pdata->ll_wr[i].off = off;
> +		pdata->ll_wr[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Read channel LL region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->ll_rd[i].bar = bar;
> +		pdata->ll_rd[i].off = off;
> +		pdata->ll_rd[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Write channel data region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->dt_wr[i].bar = bar;
> +		pdata->dt_wr[i].off = off;
> +		pdata->dt_wr[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +
> +	/* Read channel data region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->dt_rd[i].bar = bar;
> +		pdata->dt_rd[i].off = off;
> +		pdata->dt_rd[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -114,15 +194,15 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.pci_address = dw_edma_pcie_address,
>  };
>
> -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> -					   struct dw_edma_pcie_data *pdata)
> +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> +					       struct dw_edma_pcie_data *pdata)
>  {
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
>
>  	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
>  	if (!vsec)
>  		return;
>
> @@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	    PCI_VNDR_HEADER_LEN(val) != 0x18)
>  		return;
>
> -	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
>  	pci_read_config_dword(pdev, vsec + 0x8, &val);
> -	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> +	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
>  	if (map != EDMA_MF_EDMA_LEGACY &&
>  	    map != EDMA_MF_EDMA_UNROLL &&
>  	    map != EDMA_MF_HDMA_COMPAT &&
> @@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  		return;
>
>  	pdata->mf = map;
> -	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
>
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
>  	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
>
>  	pci_read_config_dword(pdev, vsec + 0x14, &val);
>  	off = val;
> @@ -157,6 +237,64 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	pdata->rg.off = off;
>  }
>
> +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> +					     struct dw_edma_pcie_data *pdata)
> +{
> +	u32 val, map;
> +	u16 vsec;
> +	u64 off;
> +
> +	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> +	    PCI_VNDR_HEADER_LEN(val) != 0x18)
> +		return;
> +
> +	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
> +	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> +	if (map != EDMA_MF_HDMA_NATIVE)
> +		return;
> +
> +	pdata->mf = map;
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> +
> +	pci_read_config_dword(pdev, vsec + 0xc, &val);
> +	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> +			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> +	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> +			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> +
> +	pci_read_config_dword(pdev, vsec + 0x14, &val);
> +	off = val;
> +	pci_read_config_dword(pdev, vsec + 0x10, &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->rg.off = off;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      &val);
> +	off = val;
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->devmem_phys_off = off;
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
>  	 * for the DMA, if one exists, then reconfigures it.
>  	 */
> -	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> +
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in xilinx_mdb_data.
> +		 */
> +		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_LL_SIZE,
> +					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +	}
>
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
> @@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> +	  (kernel_ulong_t)&xilinx_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0
>

