Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8836E6A82FF
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCBM6i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 07:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBM6h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 07:58:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC5E72AD;
        Thu,  2 Mar 2023 04:57:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcJtWWczvH+zlh2taxszbPuRyFerbFTMfpte2u504bGvQeaUicTkYOgI9nEubntRMwt5PekalLE569CaHLkccoX68Lg1ElqJXF6A0eo9RJRQIpl4q7VdQznDyTlbOC7u4CfmDCCif8GuxixdqI1twi3RYB2lgxoe4l+Aw1JePkUqAbCAe0tLINBFOa/Goa1B1jNPkO7QeDWeWl13SaUGO5Nt62c1mei2s/lskp4VlGHCctlKJs7xLAUwsdrdPQdKS++np6hx4ZldSh5l+h7D+Dq4lZGXvx8nGqQrxDHWv1eAW739fM9jQuGJ6YGSbgDx5l1+iZAcQZI/yZK0FevYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbcKwHFRFpr+ZNu4C4YZUCpP7uM3/Tdj0toQK/MGByg=;
 b=c+uoMXZ5GV3HpinBIksFLIAAcw/odaU6GWMk3fDBZ9xf+jzRINaEXE653ZvA8n8fp4mJsI9WSMp6RXVJEBNfHbYhG5cLE2Wvd19OUcbxImDHUt4WKTP/ceWuL7AUlmRaZ03Sba8KVVvu2Y66LtaqHabkhpaWaPu+6OAxnThrhQd2HGI9cJgr0+GUk/HYJfkKtLLJVvE3Gs7WkMya/Pc4dSeJm7M2alNPZUuHfPeuU7W8+cPq7ZGQENuT44N8yOSLt9Q2Xow4WomVrWB2U0jp6qfz1pp6caxAPUdDcOS/DgEw2x+i5g8U9GZLg7b3DHlBce5HePiV+msp0+21MGPGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbcKwHFRFpr+ZNu4C4YZUCpP7uM3/Tdj0toQK/MGByg=;
 b=hE27fPoB2b3GxUoYHVGdM7jKJKvEXDD+mEtxDFQ+H3bZQm2DvOoGt2sFM4adeG9VHtxOrbKcfZ7zPPx9ftotwNPJSf5hkIiIgVAqlCTwlwz7+zyqWqjTRqLWZrB9tI+WI1lxKsnB8oh8MLzW6bD7wAp8fb5M1wHUgo/+uiisX97d/vPwBms2VR+waSSSGfB6hEC5ydc8V97USFzubZrnavfQWwhKs3HkgbxtFBMPJ9nl2+8/bQdVOn2rE9aePK7u49hsRDdOtfgNx4AmaG2bRbkJ/8oPRqrG+mAvy65HbN3qgzeMIq4hUxQInu/ehdbYbh//4h+1M+Ny1YS1aKGyHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 12:57:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 12:57:50 +0000
Date:   Thu, 2 Mar 2023 08:57:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under DMA
 API
Message-ID: <ZACdTG4QZSHF2QRj@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c155d91-1fe2-453d-1767-08db1b1dbae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGzzwFqk+rozVYautXUpdwo7YM3W9XPZ0npiL3B9eRkPezj1/e7JjGvzBEVCyX+eUCDA2uOSFC+4iDtKNqTJ+xsvP6CFKevbqHNT/eK0bS4HLCB53+tfntRZcdGb8QZqIeSG1vB8TZcrsSX1W1eXb/6adO8SRhdXfrCS/7BIc5EN6eRMTzC+54L8HYw0Y3JULcr3zGzE6hY+Vfy2apyJ5iSbi3sykqbogjAHll/lXz/zMoAAHrIvc6/KNx4HQ5nBlVExnjPpbV7xHuenWkB6D02EnU7XGAlpKtnu3pHIqvH5gaGAaniHfQtl2SZ/SSV5oqqMqiy+RKA1Vtf7lvdYnp6YQUgon7CG22v7+DROG3dg/S4oPTYNBDlapzq0NVDbFBhfo48f9TwAyECYtjDYz0xDxJpkV2n+i77AuJVIFdXv65mkh7yezYg4wNo7ULtfOAIwIDnLtf2DcDCrVy4BNxLZfXBfLfbLxWJSFK8/3vqIVQrBbEHdy7Ie/vvDgRXdsYUNNd0PcvsfIX1rnPy1ew+MS8eoJ/VzHqPxxGzrsBc2UxjHy/5O3CvJOwFbUCaylUss29+cHWd23JNzxwrwgSZs9+3yy0AbjNCpU6K7Sb4W851OsqAo20mwlwLi3n4BZYIz3MO/nsn6X9Tg8fCESg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199018)(38100700002)(36756003)(86362001)(4744005)(2906002)(66556008)(66946007)(7416002)(41300700001)(66476007)(8676002)(6916009)(5660300002)(4326008)(8936002)(186003)(6512007)(6506007)(26005)(2616005)(83380400001)(478600001)(316002)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QORlVsWLbQieJ1KfyA8FR6FdE/FIVVxTcwZeC4a4KeSkY9hD3OjtmW8WEd9?=
 =?us-ascii?Q?+Z1+k/KHz+c/UmyagaaqTxIZ9Yx0rsPx1+WQC5i/hCzgZBgsSnwGPZRQjX1B?=
 =?us-ascii?Q?5a2qLjCOabE9KMjaBB07z3RG02cYx+f3thj8GHjQlWAf/ySCNxkGjl6yxh4x?=
 =?us-ascii?Q?DUAyRCfGymQ3eukYd5Q4YqSnkSuM7Dmrlc/hoNJCwoQEExYg2yBAwdD8Wg8z?=
 =?us-ascii?Q?nQBQJHlI4iMAxSbTc9BqOUHfoxtmA2zH9dOF56lYeIfpbQBH76UGaRxuG0y5?=
 =?us-ascii?Q?OWdM6NbB3ttn6hVS1saiyBznknSvWFMTtQ/yPHFZacp+YvdLZn2wWo3e9twj?=
 =?us-ascii?Q?aPZpcMWINzHtk2JZl+lYXrYcjnFUSkf6KyoVbSxmOgicwy4pyWcvHERgxPlT?=
 =?us-ascii?Q?YO4mvzWY3ixPRBc2QihjG9ONkD7fKnRtA2iCy2SPahAWRwZ8EOz7kmswR9kW?=
 =?us-ascii?Q?SSGdOwWZjr2xqN8App8pJIvvaxO5jGjkd3NOHPOwt8q5pHso7sBfjLcYNSQG?=
 =?us-ascii?Q?U0q9I6msBm6AGU7sm+gSSl9ELRTdCRO5w4jEf+zP/aP/7oyNpH6SG4Z1D/5A?=
 =?us-ascii?Q?kUdG8heCiIlDqqSYxqAJQgA6uVpGDynrByBcrKkGShgUXFxEHAzn56sB5Qdj?=
 =?us-ascii?Q?7mLBvqTozSHXbLwmrEoQiTegFoUyN3jFASPJh8AFTnZW63l4FYS9fosqx5rc?=
 =?us-ascii?Q?9HTWbbrEaUxetkk5MZ9+yBRaYgNWGi8Hq7oZuTv+qFKqTN+hMMSb1FpQy3eC?=
 =?us-ascii?Q?AKbhdZWQE1p+/nIIhUmMY2po21IYiEPzK6WNVVtSxctEWA6ufqPPAHOa+xnB?=
 =?us-ascii?Q?rQhLOBvx2n8lMdif4+SeCQz4DHII0nAeBpP3J3NhDG3ewkCKcc3EnybjQ/Lx?=
 =?us-ascii?Q?o0/l9yndJkG3OlDlxVyQ7R8KoDR0YFZ4cRiJWeXH9zVBRkK++OHaW2yM2a8z?=
 =?us-ascii?Q?z0H4TxZRQ5Yq4Yk0cN5QW8LXfF/vMBC2SBtBGikl2jh/lt6u+WchNxijQ11J?=
 =?us-ascii?Q?86i0QpcuUT4iwurl/OGRmVjPuVJ5493p/jIwM8ImmOpUsvUnog48WUBQ46pb?=
 =?us-ascii?Q?B01VqQ39K5v4HZn7qZl3CGnMtRMiRii8/VfAs//8/2RjmlI+pFOEBSCkLXdj?=
 =?us-ascii?Q?k/tMmuU+lRKJeA7gfuTjNQSETuf8Y6xQC2OBAx6b1dFPJeF2cK59NQsNQg5F?=
 =?us-ascii?Q?YNVippbzMLISaPqdNFCuRrm8SUnXbJqcM7afgNsZTUbQ15BlMSlbgTTuKMQM?=
 =?us-ascii?Q?GYrKJ0dY1WsHtJy7cPDxSBrvm0UMCKrLNWhN6CQjBIaHnS8AbBANLFYJY5O8?=
 =?us-ascii?Q?xuogwHqFurYmLFUCwD53HoW4CMq3ibS967C65squI2zw53wBs0hp+PCYOl7r?=
 =?us-ascii?Q?zNU3uVhiJ2BxL5nPDaOLQT3xfWP/NMOtrhw7bYgZjm1Q0sq5lHxvGSQtkIex?=
 =?us-ascii?Q?4NnZ5JEQHnVf36DeepGCDeTzwAaLm533ss0/hxmC1TldvtLASQdIY6XqvitZ?=
 =?us-ascii?Q?t4vXhdxNwnpHK/o6ArrEC9FoM8akhaXY6z/qz7HprGjE1Z2MKRKjB6OF4CKW?=
 =?us-ascii?Q?PbNAzLiehvafNMMa3zcmJL1r707VfT7jBxbcuOGf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c155d91-1fe2-453d-1767-08db1b1dbae5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 12:57:50.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi4JQZF0lcEyPwAL6WOqmZrqJN5k/ZYUvEkM+fhhhtv6tVNMERxdUFVHyVBVQlm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 02, 2023 at 09:47:00AM +0000, Tian, Kevin wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +	ioasid_t pasid;
> > +	int ret;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return -EPERM;
> 
> what about UNMANAGED?

Why are we checking this anyhow?

Get the domain the DMA API is using and feed it to
iommu_attach_device_pasid(). If the driver can't mirror the DMA API's
domain onto the PASID then it will just fail the attach. A domain
cannot even be NULL on x86.

Jason
