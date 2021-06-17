Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4705F3ABD1F
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jun 2021 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhFQTyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Jun 2021 15:54:12 -0400
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:10941
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232339AbhFQTyL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Jun 2021 15:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxAumthsBrcIoSCJSnIamVeKh9laqeK606ghQ4fayWpD0rLCVMCt0bbL4iKXTQ1YD0myXUx2zj6q/Jthjrld3X2zB09YHdmMOfaOb6ByUotxcsCiKDxvsaMWZ8GHvK/fbwksBOJSBRO1o+WMj1Y3WAMNG6x5oDdnXR7AHD7NJTDnRX1/a2p2UOnlg1oUkXnuAvELfLfEp36s9A9/b+aKZdXUzML1vy/0OI692AMEc9LQjitpd2Bw7GR9L9WXFpoCsQ0svEEN1zaSGkKPJOft5Wi0mdOtTmzqzXCN3FNuTdd6ydTUu6eBFqbTIQihGW0uCbgh9vCo2goXrCTXzYs+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1fUK6jb102OshIN7cLZbpIRhHx/sKCK/MmuXr9uLe4=;
 b=eUoKXMB2R65ltSoMGUbmwyZ7B3kYQv27HfvV4tSkRzz3CeR8LpS0sazV597J2fU6StY17XXz/igrEwOQKxZ/vAXWpwjp1q0PwgpLY3KYvCXzo0t/1MkW7qzcAz5tOIj6GBDONH2fPaiQ/dEZVWD1BdMBCl/zTKSsx2gLhrgLSIXLr087JycV3mSPVLyir3AWBSjMF5jfRP/hDP2SE/YTbcppfzNpZwxAOo5ILLNF0zGoP5dUPXSOtypTHujNKyXSUCrRY/wGmWY1T+yFWWfg1rV5CzNqLAkKwLkdp6LBKlcNECIEp1wsDH6+CMaGFwSsbV1uR0sK2ShhKTaB6Cc6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1fUK6jb102OshIN7cLZbpIRhHx/sKCK/MmuXr9uLe4=;
 b=URhxhAdt22QinRCDK3pU+sSo0B2YwHgusB3FQ7vf6p+RMtQwrhxVMQA0uRIfShkX59ESWhuai6bFe72sqZxzhTxAASCJ15S5L8LuK4q2topWVfx54TgWEP4RauzeYmKMle6ouk6HaL4Ybq7L+6/aw4AVwt0FUzIT/Bd7eISPIGk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7710.eurprd06.prod.outlook.com (2603:10a6:102:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 19:52:00 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Thu, 17 Jun 2021
 19:51:59 +0000
Date:   Thu, 17 Jun 2021 21:51:28 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] *** altera-msgdma: make response port optional ***
Message-ID: <cover.1623898678.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:51:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a402f8-a31d-47f1-ccc5-08d931c95eb9
X-MS-TrafficTypeDiagnostic: PAXPR06MB7710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7710D84ECFA650762E6D6D788F0E9@PAXPR06MB7710.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM7t+cjnikGU5Oco7dyiui3vrH5QzWf3MzvdNzNqxC5QonLtj/hOJIFPwp/MG2vz7Ef9yr558vvshisLozeHiQAdLUHSYEjzmfYlgiNPzCK5qMg3hJquTr4tjsm0UU+33JmfRLdT8aQGOY4Iife6HhAd+Cpe5DBiOIEm89Hz95HgDWwTxrpvs9IMD1hFust0Xf8fVgwZ9Bt8csD0lrmcAnpB67K1PtKl6eIkMybBpKUlGbre2fgxOXtlGBMLqWHAHGqEAg8g2mt6/T14vlgEI9u6hv/qa32HVDE6oCNghJQGkGQK/Yjh7fEfDAdpu6Mqf878S8ZkOkWltAXdsUZlSGfqGt9TNL5HQXU9XcmFCP+JOobhMhsz3lWRb9jZgvovlH8eQgEsayAaEIGubMxFQNguSImXdd3iqTVCxDZEy7OLDfaA774VbQLjQ6JrsMnvQqw6df5arv9bHd+6lJ3G7h4fo4CkNdTew9uhwo+3mB8vTXzCOvntKXENh5e6+ATB84fS7SaHbZ0gWH+K2J1hxpwMDqJqaWvBBkv/jM4pd2/Z4pb07KcXzwCAXKKPVlWc8NWX3UNGPVzKeFsfALPMPLJEuqy2q9L5A6sv4wpMqPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(83380400001)(8676002)(86362001)(8886007)(2616005)(478600001)(55016002)(36756003)(4744005)(38100700002)(186003)(4326008)(44832011)(16526019)(66476007)(66556008)(6666004)(66946007)(316002)(110136005)(5660300002)(8936002)(7696005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhgKvQkyGEzCqNNMohDLha/sS989wzwT1A8zekN9jfo8Oew06SPGvZoFq5Yh?=
 =?us-ascii?Q?jZlGn9wJ/oGIw2dAZkqIPUdqFKyWZLVrituYEiKis9PRtqi1n4bcSV9uu3n/?=
 =?us-ascii?Q?rcaGXmGRyc5HT2yW5Z3ODn7jHnl7zgNfM/R+uoctoSKkiFlPWz2bhWi/i7xj?=
 =?us-ascii?Q?qtXwofHV5v0DpqbHjl14HG70N6PdDLC6zv2yhLJBdL+nrerHU1tzKjTlmZMX?=
 =?us-ascii?Q?WLLLlAqiN9gB8j+ctDBEWXol1N26qKZLgLRA/Vwt77WIbvP5OXIsbZb3ftlK?=
 =?us-ascii?Q?L3rHH0n0e2Ybl1VsODLvGaLRQtXbpz2pvszuUcG6aiE7zY45r2RqldT67yPM?=
 =?us-ascii?Q?xM5MVyNGrfXu7V73Z8FVruFWjmMeGE5fMkRdMCm9vAR4NH+R7dG8MjquNzeY?=
 =?us-ascii?Q?VtPGxJ36HqNcpucKD4lKi+L0S8Zb+IjcnJeAbwX39OCuIH9Jc5m4Va2vebBl?=
 =?us-ascii?Q?qTDr6HOH9B/FvPpLViq9PwsFNZNe3TM9x6F7eYcWht/RVomSAWD3Tn+rLYFr?=
 =?us-ascii?Q?JXsP5F1BDJChNVQzL7wfM3WfZYuaZE60s7nGUqxhqinyGIAdul8Pyuncqzk5?=
 =?us-ascii?Q?LALFyeLu6Z1qJaqR9fnSnVtm8XuEabAFhGtxOkFGs9EROmT2WqkVqSCXRcXy?=
 =?us-ascii?Q?azk4A+z2JAk/mxey2G/FfzL6SWa9Lu030xXITXUyHctuhpvn7R3KD7esBM/N?=
 =?us-ascii?Q?zW4FuJIMjdMLKbZchunKTzo1/8vJ7MgU5BrZ+iA7BY1pFLoOoxW8nfnl+7Ho?=
 =?us-ascii?Q?ETvmzML/2CkVddC4Feblx4A/IcgoEh5O3fhLYddqBj3cme+0PaYf8NpUtxXW?=
 =?us-ascii?Q?WGgIHpLT/Hfn+WHHNcaXHXR+On/Tz06igchuGQXbZiJMFRsZS7o+Nfnx4BJ0?=
 =?us-ascii?Q?vca45Up8UZJrDobTF5i9ohTTgyw6Q0kAahoGmDe80Ogl0TMbamUkafUO16Tb?=
 =?us-ascii?Q?ZoP5QWeQBD4kK8mTwwsTBr6baNOYj33uT59cNlR2bz+xYgTxHQER5M1gFq+U?=
 =?us-ascii?Q?wRgCAY5MgIuDM4NzYRY/YrvyrtS3pJzxfbg921zLCAoZDnnFsnGT4tW0BnZt?=
 =?us-ascii?Q?/NQ0VgY7JceR9TE9wFsSVE9MQWqWCMxkkbl5XPuUN1tJQVHWO1xCnpBxP9W1?=
 =?us-ascii?Q?zXrTFRoyb/lc2TwBLQ4fPySYyt6rIj4pDtm9pUWgYSCsTp1/Hu2Z/aLPfClS?=
 =?us-ascii?Q?hE19P0Bv1HwYC4sXvIrQvUSAtDOQJDcuSztz7kmff4/kdSyGNO1WjszrlnpB?=
 =?us-ascii?Q?R2efVxlXNk+lMhs9tu+VIEL9lWbfxm6IQyQdq/AHc6+/TGu7iUrBUUEuL6IU?=
 =?us-ascii?Q?uNk072/vWx9e58og+DMmAC+LBVqNUkF2Pl0mr+mDGQo25ffK78//nqTNMoip?=
 =?us-ascii?Q?xFJDA++F6j9phy3ToTTs+ysEqnFP?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a402f8-a31d-47f1-ccc5-08d931c95eb9
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:51:59.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNEB0WF7uy7GGyWSHumx24MmrfRDaBRQHjbMVgHpSHwDq80dO5DG+SU30Pr0HSYy29SluFtBbCcxd7fjuL2kO4S3EspEFBVMBjAKRJAjcL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7710
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Response port can be disabled in the ip core configuration,
so allow not to specify one.

This patch serie is applicable on
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next

Olivier Dautricourt (2):
  dt-bindings: dma: altera-msgdma: make response port optional
  dmaengine: altera-msgdma: make response port optional

 .../devicetree/bindings/dma/altr,msgdma.yaml  |  4 +-
 drivers/dma/altera-msgdma.c                   | 37 +++++++++++++------
 2 files changed, 29 insertions(+), 12 deletions(-)


base-commit: 656758425f98693bd61a08f6b51c4c5aa26c9d50
--
2.31.0.rc2

