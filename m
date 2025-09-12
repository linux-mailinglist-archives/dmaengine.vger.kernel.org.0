Return-Path: <dmaengine+bounces-6479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459EB540B4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 04:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2693A8639
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C8021CC59;
	Fri, 12 Sep 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b+rOWBod"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C941D54E3;
	Fri, 12 Sep 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645708; cv=fail; b=TgqtZy5tduGwMksXQB9KSVw9kSsyFpoUTTZ/UFaPweuDj0lPSn228dhyf6uAtVKj3NGJ2Xb9Ij4jkSx3AyG6RvnwHamsoFG5UJORpKolpjX4hH+AMOXy9Onui4g3dacN4uwiQS0mgK6ePqGDbGQn+fOSogqL4x+AADk+Jw/6XpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645708; c=relaxed/simple;
	bh=WMqK8q1+lshP8l/SUUUs1k/b/cQ7b6rurlO0HhMclBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d94tKBX2PvIYMYZVrV+rWQHDOCm6FI+0xI1lx+L8Jd9lNiBZ52t+byvyqR1BDsN7WdvAsZkp0O4HHCw5HcKw+t74WLyb/hTfxLIZsRpZnQseaMpSET6kTxRnYTah8HpTEFDhBeoGdvHLfYdHECvW6lyxp2/ig5rKb+7xj3yxrRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b+rOWBod; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPK5rmuLcJH+83L1ttWr2S3T9dI7CLqKgljoE1La0kSHW4i+78IFe2cKvpmjkjNMaC0y6ImLMcOkyX3YIUfa/DVqK0m69bwrD6COJROp26O6UgjPKoIAZSZ/XJpRMrKIQrCyJvgdGStVaPdHWUsjDYg3Gu8a1SpD56gKTq/fQLNTywRRAndiOwhQ/z0+9XphrmHE/vYZZIzAFz7SjtU1R33BzXC4hdEsHWq9I0OI8+kOPsJoB3vCw1PwCUTfuYDf5O7Dvw2KYRVf/g607UHFPaAzN7rOF13tKVbe+TTHTLle+MmwR87uIdirp+S5qky+AjPNl35I/TcDEM6xIDce0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMqK8q1+lshP8l/SUUUs1k/b/cQ7b6rurlO0HhMclBk=;
 b=aiiG7enpvG6nUzgeKEeyb4U4imyAymq37L6VoQ5PypVxQUF9XCLNiyuh7WJ7OhXUuCo6quyBCNiaPmNdXqKwvaJxbl28JSRtXrE8PR+SfRfL1UzDCoPBL9Da+PUzN7k+PAfA5CuAGCCLO46vi63XUW3vQeURQDOoJ7rFGA35bms1fdPDRPpd70jstoJ++JuEz2saKjTLz1NZChGorI4VmzpER4PghUnm4LwUwRQULgHLqnogstZBODmCAvWyiKfvCpHJHfK/y4+fwwHN7pTLhF+WOaT4BxJUX1ptcybiXRVkvFRyH7kDBUqOgALZuE46XXe4olNe8Of7Y5NnnoWV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMqK8q1+lshP8l/SUUUs1k/b/cQ7b6rurlO0HhMclBk=;
 b=b+rOWBodWJdkM/8WqQmH6NCLT63FLRmqAKA5yCjTPN9EMfzEo5PYXlT6K5AHMCbTFOh1AlcOxG5Ku0tyJd4Yuz8neTsAEvyrzsynQ8rIO901uwSzqb5OtSptxCHXCehxCgwBbIWVvefoxKRpvv/s5HDNS2KSuTog9pAOsA9AD16FAOK5KWBmp6J+11EuzQLEH5iVLQkcYG72yg1AXcLqnKAPkZ9/Cqn6brtg4nHKyyD3XbahJQUTfrxVWx4sqPFLMz4TK50jm8VLeDmso401nTAq2Kkf8XSiEiXWbOARkYJdGb7GNAA0valfzzjL2fc3XtJjRDFECiJcJfnlq4ZFDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 02:54:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 02:54:59 +0000
Date: Fri, 12 Sep 2025 12:06:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma-controller
Message-ID: <20250912040628.GI5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-9-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d729ca-6ff4-444e-836b-08ddf1a7c33f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmH6ctFTMhcbHmQOjPC6u61IoV2aKENUBYkh9XzEXL5gz/PY0oKYjgDXJBbU?=
 =?us-ascii?Q?obLZUuK9kVwOVMqFl2r2bSox6mwa4nOb4NZcq6pEcDQNnUHQJmx9XtolX8cj?=
 =?us-ascii?Q?UHTTGLifKv25qgkGImTbvrUjXvQIDQU9LCElQbzyZzoRgLzzNPNh0t2UYZtp?=
 =?us-ascii?Q?eZFFECy3Mv1hEWqtiM2gzWBqrSBs/B8eY9XgQ4yrlyGypZrrcM+2JoFhR7od?=
 =?us-ascii?Q?ZkXU8d0JckVSvMgUM3Yfs11HBCkmdQNtNzSBHq4e0PgvTTyiFo1f4xWSu8pG?=
 =?us-ascii?Q?BStIPpi1tTp9tkD8uD0dTi9ZvTFgtHc7SJ+cnsc1UHdfVaHxSPwWtQPk0v8J?=
 =?us-ascii?Q?nkP1R31zYAW1+w5QKpyYTiwLc3tBof3XIhkSDNNbg4gOK08WT58elzm57S4G?=
 =?us-ascii?Q?djkyyb+EWWx9EdL+dNznBuHKzSjUgtBPDyeRsaG5uGOIFdwCcD9CZI6rgtqc?=
 =?us-ascii?Q?bD5uOCzX87P3XzuDS9ZLcRB8w1sWp4pKalqWcDZT4fghb7M4i/g5ieI23JrG?=
 =?us-ascii?Q?r3bJ214gkIBvA7JTcEDp3EMxwAMArVBrio1uuGmAktxnOohgPY1kpFZZs+t9?=
 =?us-ascii?Q?7che6655beug2IKJP+R+S2iYMTtlInP+A5SaIX+/E1oM75QqFtx+VOsr40YH?=
 =?us-ascii?Q?clNWm7A+0ARCa467KNwLowcdO5Jra0nO3hKVi428P2CETWqI+IRiVUDyH+ci?=
 =?us-ascii?Q?w35d2uMvPB5V6usD3Gd1pdEWFPwFhvjJ0iqftOpYUCJ9WvmsRB+WOtRKwU7k?=
 =?us-ascii?Q?fGe+H0j/4/b5bEuHCtsCH8vjrvfPThlPnsmadlXMkgm08bBOVpNwIbv4p2Gz?=
 =?us-ascii?Q?ag9tuYChKRWcDd3InbfinuqD1lFOQlL/WVdLeSOsYE+yoVqY9xSJuj4cQvlb?=
 =?us-ascii?Q?pigFMfg0fPGb8GFEtKUsv+N9F14f5YxE73rAdx1vVCgJEb3MKZWsNr1lhsWU?=
 =?us-ascii?Q?9+tvTYP40cHmzWy1KwmSjsSt+Ph9OBPfLMr5Xr7TH42OuESeLtN8KrNpSZ5R?=
 =?us-ascii?Q?TefYnFO/dpJdEh176IyY6l6tL4KL5djCdBH/DTPpJW5iXPMkE6QdPq+YsVwl?=
 =?us-ascii?Q?iVDUSK3R4qOsFVp8CK8pTrvcn11C6YfSHuA/UH0w6BgJcTjtYprOS8EAD16i?=
 =?us-ascii?Q?IxB+kb5X2+czeme09iTpnxnLV1x/iX+a9nCTfHt9g3qVWPKZ5fijVyN4lUKF?=
 =?us-ascii?Q?1//dekXZZ/X5JsRIzAGXMsTl5g6TGfffUuhgEPt2QC5xq5RR2jNNWbsrqm7K?=
 =?us-ascii?Q?63ZRSwn9FKyIkGuDkBalT/UCLTBiO6yct7cfpeFvrQi9A28tpzlrbwhFAa6H?=
 =?us-ascii?Q?sbTrTdFB2XshIbWAxca5OR2zLcN8WqhZK3MQHwQAooQztgZk5Fb5Cx08rFo5?=
 =?us-ascii?Q?2cL2kmF4WKvif8JKwWW76WW6qi8AlEHm5P+2I4qT2vteMEBETARtmJ+1SqXl?=
 =?us-ascii?Q?HQgxl0SYyVXRPQw4QY+Bq9gaKcHlH0WC5nJY+4ULmhliPArrcnD8MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4keHrXMJSgNrvSbZbi/pYtrPd9sxVMlcnddVmPIcq/g0fMRZv+oUpDVu5GTD?=
 =?us-ascii?Q?LjhLeAv7cLUDrXG4O/CmlOZE7A9pI+qhxqsevkoNSouGgyDe/QpDxlsIY+UB?=
 =?us-ascii?Q?UbneRmXYhZ9u618OSXFgb2bcInwWsvFIKXFw5/W6hGN2ZTpxRVacpWbO97li?=
 =?us-ascii?Q?9aOhJTWQ4S11IFpaBUYMAZn+Tf9d5D+JCxd4jGqx4cN4U18MUStCnfAD98CH?=
 =?us-ascii?Q?ABovJDyGXXfPIaqDn8Af9DdIHyCzM6yXt+YeUhT2hXBc7tVoHgEt+FqgCvR2?=
 =?us-ascii?Q?vWFF6TLKS7O/Tpm/HGZ7mBXZCJq9Y2K6n2Zl8ptuwg+2m4TsWnuoZC1+5kwJ?=
 =?us-ascii?Q?vX4XPaVh8nkkhI7wVjJAvQPon1HXeOKcsLVnubBlT5Z+58ARaXe1S4616mVn?=
 =?us-ascii?Q?rtFLw6zIQeS7TGAdvzx48pCSxw8usx6ycw2q+umQjsWeIj7rAGKfoQUeYWWC?=
 =?us-ascii?Q?pvbC9M9vPwduUKR3C5yuaoDgfA8bOKFgmekeQLMOLefIAKeiHqGzQkVogABV?=
 =?us-ascii?Q?E0wL2b20rvJ79Z9ZZCkGvN7sbULkuxCYfiRDKX7QLcgEIqHzxrrW9HWZuWVu?=
 =?us-ascii?Q?ca6DSNn4FspJvdsc+811/IdXv+eNle0l7/d3i6+QHs4F8RmdTm/QVqsropbo?=
 =?us-ascii?Q?Ix2Ylyg5GTe9vEz4iLwGQFtHf6vMq5/QDHVRV3v71igqwueoZ58eUcmP7SSZ?=
 =?us-ascii?Q?CaTyN+ud4IXIw5CL+tlVulNNYxPjhgK+bsZ7UOPZ6dlMyixESA2YTmtFjV6E?=
 =?us-ascii?Q?kXCyvCYsG6avy10n4m4ZchnvpMcvAHOftOcSsk2gxUndNyT4Nw44RaxxBEIa?=
 =?us-ascii?Q?Khjf0/dmA5+2xG+f1o3BR0CimZ96CJnz0cDrFygwr3BkpVeLUppemnuPU6Ir?=
 =?us-ascii?Q?cQ9yAKtTbBhxoGRh1qd6utg1LBMwsGnEUg1XkK/F09cHBXwjU5nKv0mn9TuH?=
 =?us-ascii?Q?8Dj0ODgFwPS6KArNHfwsnvWRfxhL/uy/scjIlzlw9yZrlG/mvwEGvdU9q44Z?=
 =?us-ascii?Q?aZ5Givs0gN74u77Z9EHSboPFD316vmFl0TsN2sb7UGDQk3pkl2sZnFbvZHbI?=
 =?us-ascii?Q?rZu7g3uosAxVB4SI8kD4D6yUN1fUysu26AbC5aaH91MU14hlrYnAlE6LooK8?=
 =?us-ascii?Q?FBItMaCuxnAztGlHgxV4tNkUpeLBeASEHgyfVnhjh6H4+qNJbE9HjGsKcwBQ?=
 =?us-ascii?Q?bSQlK1nm2OLdapXKe+ILCDKwtil0rTgG3RK7sjODW9PhMd/pnBDOzuRknCg1?=
 =?us-ascii?Q?e+bGNpSgzRzg/D+934vPpr4QEc3mNdF8W3ddWWeoB8q40F/5jzoTFQmVZe8m?=
 =?us-ascii?Q?8JeNRh7712iYap3AHBlEMme5TJl7bzSv0qn7Mibp5YxjpE5gGhr7eOjDej2a?=
 =?us-ascii?Q?4P5oq6sA3xE0mbjm6NFhKkYMeG9NK+bh9c84euWJFNzJ5ftQLhfwMSxFjHme?=
 =?us-ascii?Q?nPhWKMN8pVCjky4MV403rkal+I8TkPCM9L7bqejVz18SUpob46WyqpW2HjvK?=
 =?us-ascii?Q?5ZNIEI6zhswX7UgLo8KSMFHQaS0ZCSFC48JgU4C/QrK/vrZu1JV1GuztKpyb?=
 =?us-ascii?Q?CsSoecCZE+Agt/lEvIJHwcZjtP7Ob4mpr7oKBqeb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d729ca-6ff4-444e-836b-08ddf1a7c33f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:54:59.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wio8BuDomE8RaqsnOcEL77KofZTePtSY3Sxjd4ui0DDbbn06enYPiQH9nBk3VbbVVCwDZgR6iJTnJu0Nv8bmcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On Thu, Sep 11, 2025 at 11:56:50PM +0200, Marco Felsch wrote:
>Use the devres capabilities to cleanup the driver remove() callback.
>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

